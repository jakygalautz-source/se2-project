import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pill_pilot/api/api_config.dart';

class ReminderTimeApi {
  static Future<void> saveReminderTimes(Map<String, dynamic> data) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/reminder-times");

    final response = await http
        .post(
          url,
          body: jsonEncode(data),
          headers: {"Content-Type": "application/json"},
        )
        .timeout(const Duration(seconds: 2));

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to save reminder times");
    }
  }

  static Future<Map<String, dynamic>> getReminderTimes() async {
    final url = Uri.parse("${ApiConfig.baseUrl}/reminder-times");

    final response = await http.get(url).timeout(const Duration(seconds: 2));

    if (response.statusCode != 200) {
      throw Exception("Failed to load reminder times");
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
