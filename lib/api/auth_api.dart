import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pill_pilot/models/auth_model.dart';

class AuthApi {
  static const String baseUrl = "http://192.168.178.27:8000";

  static Future<void> register(RegisterRequest request) async {
    final url = Uri.parse('$baseUrl/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Registrierung fehlgeschlagen');
    }
  }

  static Future<AuthUser> login(LoginRequest request) async {
    final url = Uri.parse('$baseUrl/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return AuthUser.fromJson(data);
    }

    throw Exception('Login fehlgeschlagen');
  }
}
