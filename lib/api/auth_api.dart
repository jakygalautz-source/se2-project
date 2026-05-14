import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pill_pilot/models/auth_model.dart';
import 'package:pill_pilot/api/api_config.dart';

class AuthApi {
  static Future<void> register(RegisterRequest request) async {
    final url = Uri.parse('$ApiConfig.baseUrl/register');

    final response = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(request.toJson()),
        )
        .timeout(const Duration(seconds: 3));

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Registrierung fehlgeschlagen');
    }
  }

  static Future<AuthUser> login(LoginRequest request) async {
    final url = Uri.parse('$ApiConfig.baseUrl/login');

    final response = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(request.toJson()),
        )
        .timeout(const Duration(seconds: 3));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return AuthUser.fromJson(data);
    }

    throw Exception('Login fehlgeschlagen');
  }
}
