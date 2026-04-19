import 'package:flutter/material.dart';
import 'package:pill_pilot/pages/medication_page.dart';
import 'package:pill_pilot/widgets/my_medication_list_card.dart';
import 'package:provider/provider.dart';
import 'package:pill_pilot/models/medication_list_model.dart';
import 'package:pill_pilot/widgets/my_snackbar.dart';
import 'package:pill_pilot/models/reminder_time_model.dart';
import 'package:pill_pilot/services/notifications_service.dart';

class MedicationListPage extends StatefulWidget {
  const MedicationListPage({super.key});

  @override
  State<MedicationListPage> createState() => _MedicationListPageState();
}

class _MedicationListPageState extends State<MedicationListPage> {
  @override
  void initState() {
    super.initState();
    context.read<MedicationListModel>().loadMedications();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MedicationListModel>();
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(title: const Text("Meine Medikamente")),
      body: SafeArea(
        child: model.isLoading
            ? const Center(child: CircularProgressIndicator())
            : model.isEmpty
            ? const Center(child: Text('Noch keine Medikamente vorhanden'))
            : isLandscape
            ? _buildLandscape(context, model)
            : _buildPortrait(context, model),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/medication_page');
        },
        backgroundColor: const Color.fromARGB(255, 151, 185, 249),
        icon: const Icon(
          Icons.add,
          size: 30,
          color: Color.fromARGB(255, 8, 42, 69),
        ),
        label: const Text(
          "Hinzufügen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color.fromARGB(255, 8, 42, 69),
          ),
        ),
      ),
    );
  }

  Widget _buildPortrait(BuildContext context, MedicationListModel model) {
    return Scrollbar(
      thumbVisibility: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: model.medications.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final medication = model.medications[index];

            return MyMedicationListCard(
              medication: medication,
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MedicationPage(
                      isEditMode: true,
                      medication: medication,
                    ),
                  ),
                );
                if (!mounted) return;
                await model.loadMedications();
              },
              onDelete: () async {
                try {
                  await model.removeMedication(medication);

                  await NotificationsService.instance.rescheduleFromCurrentData(
                    reminderTimeModel: context.read<ReminderTimeModel>(),
                    medications: model.medications,
                  );
                } catch (_) {
                  if (!mounted) return;
                  MySnackbar.show(
                    context,
                    message: "Medikament konnte nicht gelöscht werden",
                    backgroundColor: Colors.grey.shade800,
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildLandscape(BuildContext context, MedicationListModel model) {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: (model.medications.length / 2).ceil(),
        itemBuilder: (context, rowIndex) {
          final leftIndex = rowIndex * 2;
          final rightIndex = leftIndex + 1;

          final leftMedication = model.medications[leftIndex];
          final rightMedication = rightIndex < model.medications.length
              ? model.medications[rightIndex]
              : null;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: MyMedicationListCard(
                      medication: leftMedication,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MedicationPage(
                              isEditMode: true,
                              medication: leftMedication,
                            ),
                          ),
                        );
                        if (!mounted) return;
                        await model.loadMedications();
                      },
                      onDelete: () async {
                        try {
                          await model.removeMedication(leftMedication);
                        } catch (_) {
                          if (!mounted) return;
                          MySnackbar.show(
                            context,
                            message: "Medikament konnte nicht gelöscht werden",
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: rightMedication != null
                        ? MyMedicationListCard(
                            medication: rightMedication,
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MedicationPage(
                                    isEditMode: true,
                                    medication: rightMedication,
                                  ),
                                ),
                              );
                              if (!mounted) return;
                              await model.loadMedications();
                            },
                            onDelete: () async {
                              try {
                                await model.removeMedication(rightMedication!);
                              } catch (_) {
                                if (!mounted) return;
                                MySnackbar.show(
                                  context,
                                  message:
                                      "Medikament konnte nicht gelöscht werden",
                                );
                              }
                            },
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
