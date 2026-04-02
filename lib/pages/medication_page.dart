import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/intake_slot_card.dart';
import 'package:pill_pilot/models/day_part.dart';

class MedicationPage extends StatelessWidget {
  final bool isEditMode;
  const MedicationPage({super.key, this.isEditMode = false});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditMode ? "Medikament bearbeiten" : "Medikament eingeben",
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: isLandscape
              ? _buildLandscape(context)
              : _buildPortrait(context),
        ),
      ),
    );
  }

  Widget _buildPortrait(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              labelText: "Medikament",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),

          const IntakeSlotCard(dayPart: DayPart.morning),
          const SizedBox(height: 12),
          const IntakeSlotCard(dayPart: DayPart.noon),
          const SizedBox(height: 12),
          const IntakeSlotCard(dayPart: DayPart.evening),
          const SizedBox(height: 12),
          const IntakeSlotCard(dayPart: DayPart.night),

          const SizedBox(height: 20),

          OutlinedButton(
            onPressed: () {
              // hier geht es später zu einer Page wo die Zeiten von den Dayparts angepasst werden können
            },
            child: const Text("Zeiten anpassen"),
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: () {
              // hier wird später gespeichert
            },
            child: const Text("Speichern"),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildLandscape(BuildContext context) {
    return SingleChildScrollView();
  }
}
