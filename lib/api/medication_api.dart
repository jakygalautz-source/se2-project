import 'dart:convert'; // macht aus Dart-Map echtes json
import 'package:http/http.dart' as http;

class MedicationApi {
  static const String baseUrl =
      "http://10.0.2.2:8000"; // baseUrl: wo ist mein BAckend? -> serveradresse, für emulator 10.0.2.2:8000

  static Future<void> saveMedication(Map<String, dynamic> data) async {
    final url = Uri.parse(
      "$baseUrl/medications",
    ); // ebentuell medications anpassen, je nach wie jaqui es nennt

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception();
    }
  }
}
