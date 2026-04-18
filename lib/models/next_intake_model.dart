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
    if (minutesUntil <= 0) {
      return 'jetzt fällig';
    }
    if (minutesUntil == 1) {
      return 'in 1 Minute';
    }
    return 'in $minutesUntil Minuten';
  }
}
