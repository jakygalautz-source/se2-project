import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/intake_slot_card.dart';
import 'package:pill_pilot/models/day_part.dart';
import 'package:pill_pilot/widgets/change_time_button.dart';
import 'package:pill_pilot/widgets/my_textfield.dart';
import 'package:pill_pilot/widgets/save_button.dart';

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

              MyTextfield(hintText: "Name des Medikaments eingeben"),

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

              SaveButton(
                onTap: () {
                  // hier werden das neue Medikament, die Einnahmemenge und Einnahmezeiten gespeichert
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLandscape(BuildContext context) {
    return SingleChildScrollView();
  }
}
