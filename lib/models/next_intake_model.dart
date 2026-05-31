import 'package:flutter/material.dart';
import 'package:pill_pilot/models/day_part.dart';
import 'package:pill_pilot/models/medication_model.dart';

class NextIntakeModel {
  final DayPart dayPart;
  final TimeOfDay time;
  final DateTime scheduledDateTime;
  final int minutesUntil;
  final List<Medication> medications;
  final List<Medication> medicationsWithReminder;

  NextIntakeModel({
    required this.dayPart,
    required this.time,
    required this.scheduledDateTime,
    required this.minutesUntil,
    required this.medications,
    required this.medicationsWithReminder,
  });

  bool get hasActiveReminder => medicationsWithReminder.isNotEmpty;
  bool get hasSingleMedication => medications.length == 1;

  String get title {
    if (medications.isEmpty) {
      return 'Keine Einnahme geplant';
    }
    if (medications.length == 1) {
      return medications.first.name;
    }
    return '${medications.length} Medikamente';
  }

  String get subtitle {
    if (medications.isEmpty) {
      return 'Keine Einnahme geplant';
    }

    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);

    final tomorrow = today.add(const Duration(days: 1));

    final scheduledDay = DateTime(
      scheduledDateTime.year,
      scheduledDateTime.month,
      scheduledDateTime.day,
    );

    final hour = scheduledDateTime.hour.toString().padLeft(2, '0');
    final minute = scheduledDateTime.minute.toString().padLeft(2, '0');

    if (scheduledDay == today) {
      return 'heute um $hour:$minute Uhr';
    }

    if (scheduledDay == tomorrow) {
      return 'morgen um $hour:$minute Uhr';
    }

    return '$hour:$minute Uhr';
  }
}
