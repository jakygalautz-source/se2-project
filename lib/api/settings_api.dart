import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pill_pilot/models/settings_model.dart';
import 'package:pill_pilot/api/api_config.dart';

class SettingsApi {
  static Future<SettingsModel> loadSettings() async {
    final url = Uri.parse('$ApiConfig.baseUrl/settings');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return SettingsModel.fromJson(data);
    }

    throw Exception('Settings konnten nicht geladen werden');
  }

  static Future<void> saveSettings(SettingsModel settings) async {
    final url = Uri.parse('$ApiConfig.baseUrl/settings');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(settings.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Settings konnten nicht gespeichert werden');
    }
  }
}
