import 'dart:convert'; // macht aus Dart-Map echtes json
import 'package:http/http.dart' as http;
import 'package:pill_pilot/models/medication_model.dart';
import 'package:pill_pilot/api/api_config.dart';
import 'package:pill_pilot/models/session.dart';

class MedicationApi {
  static Future<void> saveMedication(Map<String, dynamic> data) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/medications");

    final response = await http
        .post(url, headers: _headers(), body: jsonEncode(data))
        .timeout(const Duration(seconds: 2));

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception();
    }
  }

  static Map<String, String> _headers() {
    return {
      "Content-Type": "application/json",
      if (Session.token != null) "Authorization": "Bearer ${Session.token}",
    };
  }

  static Future<List<Medication>> getMedications() async {
    final url = Uri.parse(
      "${ApiConfig.baseUrl}/medications",
    ); // ebentuell medications anpassen, je nachdem wie jaqui es nennt

    final response = await http
        .get(url, headers: _headers())
        .timeout(const Duration(seconds: 2));

    if (response.statusCode != 200) {
      throw Exception();
    }

    final List<dynamic> data = jsonDecode(response.body);

    return data
        .map((item) => Medication.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static Future<void> updateMedication(
    int id,
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/medications/$id");

    final response = await http
        .put(url, headers: _headers(), body: jsonEncode(data))
        .timeout(const Duration(seconds: 2));

    if (response.statusCode != 200) {
      throw Exception();
    }
  }

  static Future<void> deleteMedication(int id) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/medications/$id");

    final response = await http
        .delete(url, headers: _headers())
        .timeout(const Duration(seconds: 2));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception();
    }
  }
}
