import 'package:flutter/material.dart';
import 'package:pill_pilot/pages/medication_page.dart';
import 'package:pill_pilot/widgets/my_medication_list_card.dart';
import 'package:provider/provider.dart';
import 'package:pill_pilot/models/medication_list_model.dart';

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

    return Scaffold(
      appBar: AppBar(title: const Text("Meine Medikamente")),
      body: model.isLoading
          ? const Center(child: CircularProgressIndicator())
          : model.isEmpty
          ? const Center(child: Text('Noch keine Medikamente vorhanden'))
          : ListView.separated(
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
                );
              },
            ),
    );
  }
}

// TODO landscape modus
