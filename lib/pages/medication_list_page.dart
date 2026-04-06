import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/my_medication_list_card.dart';
import 'package:pill_pilot/models/medication_intake_model.dart';
import 'package:pill_pilot/models/medication_model.dart';

class MedicationListPage extends StatelessWidget {
  const MedicationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final medications = [
      Medication(
        name: 'Mexalen',
        intakes: [
          MedicationIntakeModel(
            dayPart: 'morning',
            amount: 2.0,
            reminder: true,
          ),
          MedicationIntakeModel(dayPart: 'evening', amount: 1, reminder: false),
        ],
      ),
      Medication(
        name: 'Ibuprofen',
        intakes: [
          MedicationIntakeModel(dayPart: 'noon', amount: 1.0, reminder: true),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Meine Medikamente")),
      body: medications.isEmpty
          ? const Center(child: Text('Noch keine Medikamente vorhanden'))
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: medications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return MyMedicationListCard(
                  medication: medications[index],
                  onTap: () {
                    // hier werde ich navigieren zu medication_page
                  },
                );
              },
            ),
    );
  }
}

// TODO landscape modus
