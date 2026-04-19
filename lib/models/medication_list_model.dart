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

  Future<void> removeMedication(Medication medication) async {
    if (medication.id == null) {
      throw Exception();
    }

    await MedicationApi.deleteMedication(medication.id!);
    medications.removeWhere((item) => item.id == medication.id);
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

      Medication(
        name: 'Bisoprolol (Betablocker)',
        intakes: [
          MedicationIntakeModel(
            dayPart: 'morning',
            amount: 1.0,
            reminder: true,
          ),
        ],
      ),
      Medication(
        name: 'Eliquis (Blutverdünner)',
        intakes: [
          MedicationIntakeModel(
            dayPart: 'morning',
            amount: 1.0,
            reminder: true,
          ),
          MedicationIntakeModel(
            dayPart: 'evening',
            amount: 1.0,
            reminder: true,
          ),
        ],
      ),
      Medication(
        name: 'Atorvastatin (Cholesterin)',
        intakes: [
          MedicationIntakeModel(
            dayPart: 'evening',
            amount: 1.0,
            reminder: true,
          ),
        ],
      ),

      Medication(
        name: 'Zolpidem (Schlafmittel)',
        intakes: [
          MedicationIntakeModel(dayPart: 'night', amount: 0.5, reminder: true),
        ],
      ),

      Medication(
        name: 'Ramipril',
        intakes: [
          MedicationIntakeModel(
            dayPart: 'morning',
            amount: 1.0,
            reminder: true,
          ),
        ],
      ),
      Medication(
        name: 'Torasemid (Diuretikum)',
        intakes: [
          MedicationIntakeModel(
            dayPart: 'morning',
            amount: 1.0,
            reminder: false,
          ),
        ],
      ),

      Medication(
        name: 'Pantoprazol (Magenschutz)',
        intakes: [
          MedicationIntakeModel(
            dayPart: 'morning',
            amount: 1.0,
            reminder: false,
          ),
        ],
      ),
      Medication(
        name: 'Vitamin D',
        intakes: [
          MedicationIntakeModel(
            dayPart: 'morning',
            amount: 1.0,
            reminder: false,
          ),
        ],
      ),
    ];
  }
}
