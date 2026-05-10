import 'package:flutter/material.dart';
import 'package:pill_pilot/api/medication_api.dart';
import 'package:pill_pilot/widgets/intake_slot_card.dart';
import 'package:pill_pilot/models/day_part.dart';
import 'package:pill_pilot/widgets/change_time_button.dart';
import 'package:pill_pilot/widgets/my_textfield.dart';
import 'package:pill_pilot/widgets/save_button.dart';
import 'package:provider/provider.dart';
import 'package:pill_pilot/models/medication_form_model.dart';
import 'package:pill_pilot/models/medication_model.dart';
import 'package:pill_pilot/models/medication_list_model.dart';
import 'package:pill_pilot/widgets/my_snackbar.dart';
import 'package:pill_pilot/services/notifications_service.dart';
import 'package:pill_pilot/models/reminder_time_model.dart';
import 'package:pill_pilot/data/medication_suggestions.dart';

class MedicationPage extends StatefulWidget {
  final bool isEditMode;
  final Medication? medication;

  const MedicationPage({super.key, this.isEditMode = false, this.medication});

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  final TextEditingController medicationNameController =
      TextEditingController();

  bool isSaving = false;
  bool showNameError = false;

  @override
  void initState() {
    super.initState();

    if (widget.medication != null) {
      final medicationFormModel = context.read<MedicationFormModel>();
      medicationFormModel.loadMedication(widget.medication!);
      medicationNameController.text = widget.medication!.name;
    }
  }

  @override
  void dispose() {
    medicationNameController.dispose();
    super.dispose();
  }

  void _handleSave() async {
    // async weil ich später "await" nutze
    final medicationFormModel = context.read<MedicationFormModel>();
    final medicationListModel = context.read<MedicationListModel>();
    final normalizedName = medicationFormModel.medicationName
        .trim()
        .toLowerCase();
    final navigator = Navigator.of(context);
    final reminderTimeModel = context.read<ReminderTimeModel>();

    if (medicationNameController.text.trim().isEmpty) {
      setState(() => showNameError = true);

      MySnackbar.show(
        context,
        message: "Bitte einen Medikamentennamen eingeben",
        backgroundColor: Colors.grey.shade800,
      );

      return;
    }

    if (!medicationFormModel.isValid) {
      MySnackbar.show(
        context,
        message: "Bitte alle Felder ausfüllen",
        backgroundColor: Colors.grey.shade800,
      );
      return;
    }

    if (!widget.isEditMode) {
      final alreadyExists = medicationListModel.medications.any(
        (medication) => medication.name.trim().toLowerCase() == normalizedName,
      );

      if (alreadyExists) {
        MySnackbar.show(
          context,
          message: "Dieses Medikament ist bereits vorhanden",
          backgroundColor: Colors.grey,
        );
        return;
      }
    }

    setState(() => isSaving = true);

    try {
      await MedicationApi.saveMedication(medicationFormModel.toJson());
    } catch (_) {
      if (!mounted) return;

      MySnackbar.show(
        context,
        message: "Medikament konnte nicht gespeichert werden",
        backgroundColor: Colors.grey.shade800,
      );

      setState(() => isSaving = false);
      return;
    }

    if (!mounted) {
      return;
    } // schaut ob widget noch im UI drin ist um absturz nach await zu vermeiden

    await medicationListModel.loadMedications();

    await NotificationsService.instance.rescheduleFromCurrentData(
      reminderTimeModel: reminderTimeModel,
      medications: medicationListModel.medications,
    );

    medicationFormModel.reset();
    medicationNameController.clear();

    if (!mounted) return;
    navigator.pushReplacementNamed('/medication_list_page');

    setState(() => isSaving = false); // brauch ich hier eigentlich nicht mehr
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditMode ? "Medikament bearbeiten" : "Medikament eingeben",
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLandscape ? _buildLandscape(context) : _buildPortrait(context),
      ),
      bottomNavigationBar: isLandscape
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 8, 25, 12),
                child: SaveButton(onTap: _handleSave, isLoading: isSaving),
              ),
            ),
    );
  }

  Widget _buildPortrait(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<String>.empty();
                  }

                  return medicationSuggestions.where((medication) {
                    return medication.toLowerCase().contains(
                      textEditingValue.text.toLowerCase(),
                    );
                  });
                },

                onSelected: (selection) {
                  medicationNameController.text = selection;

                  context.read<MedicationFormModel>().setMedicationName(
                    selection,
                  );

                  FocusScope.of(context).unfocus();

                  if (showNameError) {
                    setState(() => showNameError = false);
                  }
                },

                fieldViewBuilder:
                    (
                      context,
                      textEditingController,
                      focusNode,
                      onFieldSubmitted,
                    ) {
                      textEditingController.text =
                          medicationNameController.text;

                      return MyTextfield(
                        controller: textEditingController,
                        focusNode: focusNode,
                        hintText: "Name des Medikaments eingeben",
                        borderColor: showNameError
                            ? Colors.redAccent
                            : Colors.grey.shade400,
                        onSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        onChanged: (value) {
                          medicationNameController.text = value;
                          context.read<MedicationFormModel>().setMedicationName(
                            value,
                          );

                          if (showNameError && value.trim().isNotEmpty) {
                            setState(() => showNameError = false);
                          }
                        },
                      );
                    },
              ),

              const SizedBox(height: 16),

              const IntakeSlotCard(dayPart: DayPart.morning),
              const SizedBox(height: 12),
              const IntakeSlotCard(dayPart: DayPart.noon),
              const SizedBox(height: 12),
              const IntakeSlotCard(dayPart: DayPart.evening),
              const SizedBox(height: 12),
              const IntakeSlotCard(dayPart: DayPart.night),
              const SizedBox(height: 16),

              ChangeTimeButton(
                onTap: () {
                  // hier geht es dann weiter zum Zeiten-ändern page (= page der Erinnerungsfunktionseinstellungen)
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLandscape(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // linke Seite
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      }

                      return medicationSuggestions.where((medication) {
                        return medication.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        );
                      });
                    },

                    onSelected: (selection) {
                      medicationNameController.text = selection;

                      context.read<MedicationFormModel>().setMedicationName(
                        selection,
                      );

                      FocusScope.of(context).unfocus();

                      if (showNameError) {
                        setState(() => showNameError = false);
                      }
                    },

                    fieldViewBuilder:
                        (
                          context,
                          textEditingController,
                          focusNode,
                          onFieldSubmitted,
                        ) {
                          textEditingController.text =
                              medicationNameController.text;

                          return MyTextfield(
                            controller: textEditingController,

                            hintText: "Name des Medikaments eingeben",

                            borderColor: showNameError
                                ? Colors.redAccent
                                : Colors.grey.shade400,

                            onChanged: (value) {
                              medicationNameController.text = value;

                              context
                                  .read<MedicationFormModel>()
                                  .setMedicationName(value);

                              if (showNameError && value.trim().isNotEmpty) {
                                setState(() => showNameError = false);
                              }
                            },
                          );
                        },
                  ),

                  const SizedBox(height: 16),

                  ChangeTimeButton(
                    onTap: () {
                      // hier können die Zeiten der 4 slots ausgewählt werden --> eigene Page
                    },
                  ),
                  const SizedBox(height: 16),
                  SaveButton(onTap: _handleSave, isLoading: isSaving),
                ],
              ),
            ),
          ),

          // Rechte Seite
          Expanded(
            flex: 7,
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(12, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),

                    IntakeSlotCard(dayPart: DayPart.morning),
                    SizedBox(height: 12),

                    IntakeSlotCard(dayPart: DayPart.noon),
                    SizedBox(height: 12),

                    IntakeSlotCard(dayPart: DayPart.evening),
                    SizedBox(height: 12),

                    IntakeSlotCard(dayPart: DayPart.night),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
