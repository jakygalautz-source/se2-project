import 'package:flutter/material.dart';
import 'package:pill_pilot/models/intake_slot_model.dart';
import 'package:pill_pilot/models/medication_form_model.dart';
import 'package:pill_pilot/pages/home_page.dart';
import 'package:pill_pilot/pages/medication_list_page.dart';
import 'package:pill_pilot/pages/medication_page.dart';
import 'package:provider/provider.dart';
import 'package:pill_pilot/models/medication_list_model.dart';
// import 'package:pill_pilot/pages/test_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IntakeSlotModel()),
        ChangeNotifierProxyProvider<IntakeSlotModel, MedicationFormModel>(
          create: (context) => MedicationFormModel(
            intakeSlotModel: context.read<IntakeSlotModel>(),
          ),
          update: (context, intakeSlotModel, previous) =>
              previous ?? MedicationFormModel(intakeSlotModel: intakeSlotModel),
        ),
        ChangeNotifierProvider(create: (context) => MedicationListModel()),
      ],
      child: const MainApp(),
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

      // home: TestPage(),
      home: HomePage(),

      routes: {
        '/home_page': (context) => HomePage(),
        '/medication_page': (context) => MedicationPage(),
        '/medication_list_page': (context) => MedicationListPage(),
      },
    );
  }
}
