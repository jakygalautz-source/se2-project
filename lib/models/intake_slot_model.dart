// logik für intakeslot und remindertoggelbutton

import 'package:flutter/material.dart';
import 'package:pill_pilot/models/day_part.dart';

class IntakeSlotModel extends ChangeNotifier {
  final Map<DayPart, double> amounts = {
    DayPart.morning: 0,
    DayPart.noon: 0,
    DayPart.evening: 0,
    DayPart.night: 0,
  };

  final Map<DayPart, bool> reminders = {
    DayPart.morning: false,
    DayPart.noon: false,
    DayPart.evening: false,
    DayPart.night: false,
  };

  double getAmount(DayPart dayPart) {
    return amounts[dayPart] ?? 0;
  }

  bool isReminderEnabled(DayPart dayPart) {
    return reminders[dayPart] ?? false;
  }

  String getUnitText(DayPart dayPart) {
    double amount = amounts[dayPart] ?? 0;
    if (amount == 1.0 || amount == 0.5) {
      return "Tablette";
    } else {
      return "Tabletten";
    }
  }

  void addHalf(DayPart dayPart) {
    amounts[dayPart] = (amounts[dayPart] ?? 0) + 0.5;
    notifyListeners();
  }

  void addOne(DayPart dayPart) {
    amounts[dayPart] = (amounts[dayPart] ?? 0) + 1;
    notifyListeners();
  }

  void removeHalf(DayPart dayPart) {
    final current = amounts[dayPart] ?? 0;

    if (current >= 0.5) {
      amounts[dayPart] = current - 0.5;
    } else {
      amounts[dayPart] = 0;
    }

    if (amounts[dayPart] == 0) {
      reminders[dayPart] = false;
    }

    notifyListeners();
  }

  void removeOne(DayPart dayPart) {
    final current = amounts[dayPart] ?? 0;

    if (current >= 1) {
      amounts[dayPart] = current - 1;
    } else {
      amounts[dayPart] = 0;
    }

    if (amounts[dayPart] == 0) {
      reminders[dayPart] = false;
    }

    notifyListeners();
  }

  void clear(DayPart dayPart) {
    amounts[dayPart] = 0;
    reminders[dayPart] = false;
    notifyListeners();
  }

  void toggleReminder(DayPart dayPart) {
    if ((amounts[dayPart] ?? 0) <= 0) {
      return;
    }
    reminders[dayPart] = !(reminders[dayPart] ?? false);
    notifyListeners();
  }

  void setIntake(DayPart dayPart, double amount, bool isEnabled) {
    amounts[dayPart] = amount;
    reminders[dayPart] = amount > 0 ? isEnabled : false;
    notifyListeners();
  }

  void resetAll() {
    for (final dayPart in DayPart.values) {
      amounts[dayPart] = 0;
      reminders[dayPart] = false;
    }
    notifyListeners();
  }
}
