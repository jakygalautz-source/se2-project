import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pill_pilot/api/api_config.dart';
import 'package:pill_pilot/models/session.dart';

class ReminderTimeApi {
  static Map<String, String> _headers() {
    return {
      'Content-Type': 'application/json',
      if (Session.token != null) 'Authorization': 'Bearer ${Session.token}',
    };
  }

  static Future<void> saveReminderTimes(Map<String, dynamic> data) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/reminder-times");

    final response = await http
        .post(url, body: jsonEncode(data), headers: _headers())
        .timeout(const Duration(seconds: 2));

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to save reminder times");
    }
  }

  static Future<Map<String, dynamic>> getReminderTimes() async {
    final url = Uri.parse("${ApiConfig.baseUrl}/reminder-times");

    final response = await http
        .get(url, headers: _headers())
        .timeout(const Duration(seconds: 2));

    if (response.statusCode != 200) {
      throw Exception("Failed to load reminder times");
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
