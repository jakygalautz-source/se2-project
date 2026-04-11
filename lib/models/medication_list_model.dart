import 'package:flutter/material.dart';
import 'package:pill_pilot/models/medication_intake_model.dart';
import 'package:pill_pilot/models/medication_model.dart';
import 'package:pill_pilot/api/medication_api.dart';

class MedicationListModel extends ChangeNotifier {
  List<Medication> medications = [];

  bool isLoading = false;

  Future<void> loadMedications() async {
    isLoading = true;
    notifyListeners();

    try {
      medications = await MedicationApi.getMedications();
    } catch (_) {
      //await Future.delayed(const Duration(milliseconds: 300));
      medications = _getFakeMedications();
    }

    isLoading = false;
    notifyListeners();
  }

  bool get isEmpty => medications.isEmpty;

  List<Medication> _getFakeMedications() {
    return [
      Medication(
        name: 'Mexalen',
        intakes: [
          MedicationIntakeModel(
            dayPart: 'morning',
            amount: 2.0,
            reminder: true,
          ),
          MedicationIntakeModel(dayPart: 'evening', amount: 1, reminder: false),
        ],
      ),
      Medication(
        name: 'Ibuprofen',
        intakes: [
          MedicationIntakeModel(dayPart: 'noon', amount: 1.0, reminder: true),
        ],
      ),
    ];
  }
}
