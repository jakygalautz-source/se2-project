import 'package:pill_pilot/models/medication_intake_model.dart';

class Medication {
  final String name;
  final List<MedicationIntakeModel> intakes;

  Medication({required this.name, required this.intakes});

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      name: json['name'] ?? '',
      intakes: (json['intakes'] as List<dynamic>? ?? [])
          .map(
            (e) => MedicationIntakeModel.fromJson(e),
          ) // bedeutet: geh durch jedes element der Liste
          .toList(),
    );
  }
}
