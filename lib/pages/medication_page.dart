import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/intake_slot_card.dart';
import 'package:pill_pilot/models/day_part.dart';
import 'package:pill_pilot/widgets/change_time_button.dart';
import 'package:pill_pilot/widgets/my_textfield.dart';
import 'package:pill_pilot/widgets/save_button.dart';
import 'package:provider/provider.dart';
import 'package:pill_pilot/models/medication_form_model.dart';

class MedicationPage extends StatefulWidget {
  final bool isEditMode;
  const MedicationPage({super.key, this.isEditMode = false});

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  final TextEditingController medicationNameController =
      TextEditingController();

  @override
  void dispose() {
    medicationNameController.dispose();
    super.dispose();
  }

  void _handleSave() {
    final medicationFormModel = context.read<MedicationFormModel>();

    if (!medicationFormModel.isValid) {
      debugPrint("Formular unvollständig");
      return;
    }

    debugPrint(medicationFormModel.toJson().toString());

    medicationFormModel.reset();
    medicationNameController.clear();
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
    );
  }

  Widget _buildPortrait(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              MyTextfield(
                controller: medicationNameController,
                hintText: "Name des Medikaments eingeben",
                onChanged: (value) {
                  context.read<MedicationFormModel>().setMedicationName(value);
                },
              ),

              const SizedBox(height: 16),

              ChangeTimeButton(
                onTap: () {
                  // hier geht es dann weiter zum Zeiten-ändern page (= page der Erinnerungsfunktionseinstellungen)
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

              const SizedBox(height: 20),

              SaveButton(onTap: _handleSave),

              const SizedBox(height: 20),
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
                  MyTextfield(
                    controller: medicationNameController,
                    hintText: "Name des Medikaments eingeben",
                    onChanged: (value) {
                      context.read<MedicationFormModel>().setMedicationName(
                        value,
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
                  SaveButton(onTap: _handleSave),
                ],
              ),
            ),
          ),

          // Rechte Seite
          Expanded(
            flex: 7,
            child: Scrollbar(
              thumbVisibility: true,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: SingleChildScrollView(
                  child: Column(
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
          ),
        ],
      ),
    );
  }
}
