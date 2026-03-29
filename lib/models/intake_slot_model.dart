import 'package:flutter/material.dart';
import 'package:pill_pilot/models/day_part.dart';

class IntakeSlotModel extends ChangeNotifier {
  final Map<DayPart, double> amounts = {
    DayPart.morning: 0,
    DayPart.noon: 0,
    DayPart.evening: 0,
    DayPart.night: 0,
  };

  double getAmount(DayPart dayPart) {
    return amounts[dayPart] ?? 0;
  }

  void addHalf(DayPart dayPart) {
    amounts[dayPart] = (amounts[dayPart] ?? 0) + 0.5;
    notifyListeners();
  }

  void addOne(DayPart dayPart) {
    amounts[dayPart] = (amounts[dayPart] ?? 0) + 1;
    notifyListeners();
  }

  void clear(DayPart dayPart) {
    amounts[dayPart] = 0;
    notifyListeners();
  }
}
