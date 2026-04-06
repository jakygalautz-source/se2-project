import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/my_medication_list_card.dart';
import 'package:pill_pilot/models/medication_intake_model.dart';
import 'package:pill_pilot/models/medication_model.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test Page")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            MyMedicationListCard(
              medication: Medication(
                name: 'Mexalen',
                intakes: [
                  MedicationIntakeModel(
                    dayPart: 'morning',
                    amount: 2.0,
                    reminder: true,
                  ),
                  MedicationIntakeModel(
                    dayPart: 'night',
                    amount: 1.0,
                    reminder: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
