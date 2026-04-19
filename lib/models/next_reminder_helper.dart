import 'package:flutter/material.dart';
import 'package:pill_pilot/models/day_part.dart';
import 'package:pill_pilot/models/medication_model.dart';
import 'package:pill_pilot/models/next_intake_model.dart';
import 'package:pill_pilot/models/reminder_time_model.dart';

class NextReminderHelper {
  static NextIntakeModel? calculate({
    required DateTime now,
    required ReminderTimeModel reminderTimeModel,
    required List<Medication> medications,
  }) {
    final List<_CandidateReminder> candidates = [];

    for (final dayPart in DayPart.values) {
      final medicationsWithReminder = medications.where((medication) {
        return medication.intakes.any(
          (intake) =>
              intake.dayPart == dayPart.name &&
              intake.amount > 0 &&
              intake.reminder,
        );
      }).toList();

      if (medicationsWithReminder.isEmpty) continue;

      final time = reminderTimeModel.getTime(dayPart);
      final scheduledDateTime = _buildNextDateTime(now, time);
      final minutesUntil = scheduledDateTime.difference(now).inMinutes;

      candidates.add(
        _CandidateReminder(
          dayPart: dayPart,
          time: time,
          scheduledDateTime: scheduledDateTime,
          minutesUntil: minutesUntil,
          medicationsWithReminder: medicationsWithReminder,
        ),
      );
    }

    if (candidates.isEmpty) return null;

    candidates.sort(
      (a, b) => a.scheduledDateTime.compareTo(b.scheduledDateTime),
    );

    final next = candidates.first;

    return NextIntakeModel(
      dayPart: next.dayPart,
      time: next.time,
      scheduledDateTime: next.scheduledDateTime,
      minutesUntil: next.minutesUntil,
      medications: next.medicationsWithReminder,
      medicationsWithReminder: next.medicationsWithReminder,
    );
  }

  static DateTime _buildNextDateTime(DateTime now, TimeOfDay time) {
    final today = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (today.isAfter(now)) {
      return today;
    }

    return today.add(const Duration(days: 1));
  }
}

class _CandidateReminder {
  final DayPart dayPart;
  final TimeOfDay time;
  final DateTime scheduledDateTime;
  final int minutesUntil;
  final List<Medication> medicationsWithReminder;

  _CandidateReminder({
    required this.dayPart,
    required this.time,
    required this.scheduledDateTime,
    required this.minutesUntil,
    required this.medicationsWithReminder,
  });
}
