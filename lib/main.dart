import 'package:flutter/material.dart';
import 'package:pill_pilot/models/intake_slot_model.dart';
// import 'package:pill_pilot/pages/home_page.dart';
import 'package:pill_pilot/pages/test_add_medication.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      child: const MainApp(),
      create: (context) => IntakeSlotModel(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),

      home: TestAddMedication(),
    );
  }
}
