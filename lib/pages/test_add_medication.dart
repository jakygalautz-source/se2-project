import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/intake_slot_card.dart';

class TestAddMedication extends StatelessWidget {
  const TestAddMedication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test Intake")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            IntakeSlotCard(dayPart: DayPart.morning),
            SizedBox(height: 12),
            IntakeSlotCard(dayPart: DayPart.noon),
            SizedBox(height: 12),
            IntakeSlotCard(dayPart: DayPart.evening),
            SizedBox(height: 12),
            IntakeSlotCard(dayPart: DayPart.night),
          ],
        ),
      ),
    );
  }
}
