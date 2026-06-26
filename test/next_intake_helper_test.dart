import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pill_pilot/models/day_part.dart';
import 'package:pill_pilot/models/medication_intake_model.dart';
import 'package:pill_pilot/models/medication_model.dart';
import 'package:pill_pilot/models/next_intake_helper.dart';
import 'package:pill_pilot/models/reminder_time_model.dart';

Medication createMedication({
  required String name,
  required String dayPart,
}) {
  return Medication(
    id: 1,
    name: name,
    intakes: [
      MedicationIntakeModel(
        dayPart: dayPart,
        amount: 1.0,
        reminder: true,
      ),
    ],
  );
}

void main() {
  test('NextIntakeHelper waehlt die naechste Einnahme nach Zeit', () {
    final reminderTimeModel = ReminderTimeModel();

    reminderTimeModel.setTime(
      DayPart.morning,
      const TimeOfDay(hour: 8, minute: 0),
    );

    reminderTimeModel.setTime(
      DayPart.noon,
      const TimeOfDay(hour: 12, minute: 0),
    );

    reminderTimeModel.setTime(
      DayPart.evening,
      const TimeOfDay(hour: 18, minute: 0),
    );

    reminderTimeModel.setTime(
      DayPart.night,
      const TimeOfDay(hour: 22, minute: 0),
    );

    final medications = [
      createMedication(name: 'Abend Medikament', dayPart: 'evening'),
      createMedication(name: 'Mittag Medikament', dayPart: 'noon'),
    ];

    final nextIntake = NextIntakeHelper.calculate(
      now: DateTime(2026, 6, 15, 10, 0),
      reminderTimeModel: reminderTimeModel,
      medications: medications,
    );

    expect(nextIntake, isNotNull);
    expect(nextIntake!.dayPart, DayPart.noon);
    expect(nextIntake.scheduledDateTime.hour, 12);
    expect(nextIntake.medications.first.name, 'Mittag Medikament');
  });

  test('NextIntakeHelper nimmt morgige Einnahme, wenn heutige Zeit vorbei ist', () {
    final reminderTimeModel = ReminderTimeModel();

    reminderTimeModel.setTime(
      DayPart.morning,
      const TimeOfDay(hour: 8, minute: 0),
    );

    final medications = [
      createMedication(name: 'Morgen Medikament', dayPart: 'morning'),
    ];

    final nextIntake = NextIntakeHelper.calculate(
      now: DateTime(2026, 6, 15, 10, 0),
      reminderTimeModel: reminderTimeModel,
      medications: medications,
    );

    expect(nextIntake, isNotNull);
    expect(nextIntake!.dayPart, DayPart.morning);
    expect(nextIntake.scheduledDateTime.day, 16);
    expect(nextIntake.scheduledDateTime.hour, 8);
  });
}