import 'package:flutter/material.dart';
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
      medications = [];
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
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
}
