import 'package:flutter/material.dart';
import 'package:pill_pilot/models/day_part.dart';
import 'package:pill_pilot/models/intake_slot_model.dart';

class MedicationFormModel extends ChangeNotifier {
  final IntakeSlotModel intakeSlotModel;

  String medicationName = '';

  MedicationFormModel({required this.intakeSlotModel}) {
    intakeSlotModel.addListener(_onIntakeChanged);
  }

  void _onIntakeChanged() {
    //wenn sich etwas in den Slots ändert -> sag allen Bescheid, die auf das FormModel hören
    notifyListeners();
  }

  void setMedicationName(String value) {
    // setzt die Medikamentenname
    medicationName = value;
    notifyListeners();
  }

  bool get hasAnyIntake {
    // checkt über IntakeSlotModel ob es daten gibt
    return DayPart.values.any(
      (dayPart) => intakeSlotModel.getAmount(dayPart) > 0,
    );
  }

  bool get isValid {
    // prüft ob formular speicherbar ist -> gibt es ein medikamentenname und daten über IntakeSlots?
    return medicationName.trim().isNotEmpty && hasAnyIntake;
  }

  // daten aus den intakeslots in einer Liste hinein-mappen:
  List<Map<String, dynamic>> getIntakesAsList() {
    // dynamic bedeutet dass die Liste gemischte Datentypen beinhaltet (string, double bool)
    return DayPart.values
        .where((dayPart) => intakeSlotModel.getAmount(dayPart) > 0)
        .map(
          (dayPart) => {
            'dayPart': dayPart.name,
            'amount': intakeSlotModel.getAmount(dayPart),
            'reminder': intakeSlotModel.isReminderEnabled(dayPart),
          },
        )
        .toList();
  }

  //JSON bauen
  Map<String, dynamic> toJson() {
    return {'name': medicationName.trim(), 'intakes': getIntakesAsList()};
  }

  // alles zurücksetzen z.B. nach dem erfolgreichen speichern
  void reset() {
    medicationName = '';

    for (final dayPart in DayPart.values) {
      intakeSlotModel.clear(dayPart);

      if (intakeSlotModel.isReminderEnabled(dayPart)) {
        intakeSlotModel.toggleReminder(dayPart);
      }
    }

    notifyListeners();
  }

  // so wird die klasse immer wieder "aufgeräumt
  @override
  void dispose() {
    intakeSlotModel.removeListener(_onIntakeChanged);
    super.dispose();
  }
}
