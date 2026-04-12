import 'package:flutter/material.dart';
import 'package:pill_pilot/models/day_part.dart';

class ReminderTimeModel extends ChangeNotifier {
  final Map<DayPart, TimeOfDay> times = {
    DayPart.morning: const TimeOfDay(hour: 8, minute: 0),
    DayPart.noon: const TimeOfDay(hour: 12, minute: 0),
    DayPart.evening: const TimeOfDay(hour: 17, minute: 0),
    DayPart.night: const TimeOfDay(hour: 21, minute: 0),
  };

  TimeOfDay getTime(DayPart dayPart) => times[dayPart]!;

  void setTime(DayPart dayPart, TimeOfDay newTime) {
    times[dayPart] = newTime;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'morning': _formatTime(times[DayPart.morning]!),
      'noon': _formatTime(times[DayPart.noon]!),
      'evening': _formatTime(times[DayPart.evening]!),
      'night': _formatTime(times[DayPart.night]!),
    };
  }

  void loadFromJson(Map<String, dynamic> json) {
    if (json['morning'] != null) {
      times[DayPart.morning] = _parseTime(json['morning'] as String);
    }
    if (json['noon'] != null) {
      times[DayPart.noon] = _parseTime(json['noon'] as String);
    }
    if (json['evening'] != null) {
      times[DayPart.evening] = _parseTime(json['evening'] as String);
    }
    if (json['night'] != null) {
      times[DayPart.night] = _parseTime(json['night'] as String);
    }

    notifyListeners();
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  TimeOfDay _parseTime(String value) {
    final parts = value.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}
