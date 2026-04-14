import 'dart:convert'; // macht aus Dart-Map echtes json
import 'package:http/http.dart' as http;
import 'package:pill_pilot/models/medication_model.dart';

class MedicationApi {
  static const String baseUrl =
      "http://10.0.2.2:8000"; // baseUrl: wo ist mein BAckend? -> serveradresse, für emulator 10.0.2.2:8000

  static Future<void> saveMedication(Map<String, dynamic> data) async {
    final url = Uri.parse(
      "$baseUrl/medications", // ebentuell medications anpassen, je nachdem wie jaqui es nennt
    );

    final response = await http
        .post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data),
        )
        .timeout(const Duration(seconds: 2));

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception();
    }
  }

  static Future<List<Medication>> getMedications() async {
    final url = Uri.parse(
      "$baseUrl/medications",
    ); // ebentuell medications anpassen, je nachdem wie jaqui es nennt

    final response = await http.get(url).timeout(const Duration(seconds: 2));

    if (response.statusCode != 200) {
      throw Exception();
    }

    final List<dynamic> data = jsonDecode(response.body);

    return data
        .map((item) => Medication.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static Future<void> deleteMedication(int id) async {
    final url = Uri.parse("$baseUrl/medications/$id");

    final response = await http.delete(url).timeout(const Duration(seconds: 2));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception();
    }
  }
}
