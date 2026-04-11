class MedicationIntakeModel {
  final String dayPart;
  final double amount;
  final bool reminder;

  MedicationIntakeModel({
    required this.dayPart,
    required this.amount,
    required this.reminder,
  });

  factory MedicationIntakeModel.fromJson(Map<String, dynamic> json) {
    return MedicationIntakeModel(
      dayPart: json['dayPart'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      reminder: json['reminder'] ?? false,
    );
  }
}
