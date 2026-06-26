import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:pill_pilot/pages/medication_list_page.dart';
import 'package:pill_pilot/models/medication_list_model.dart';
import 'package:pill_pilot/models/reminder_time_model.dart';
import 'package:pill_pilot/models/medication_model.dart';
import 'package:pill_pilot/models/medication_intake_model.dart';

class FakeMedicationListModel extends MedicationListModel {
  FakeMedicationListModel(List<Medication> initialMedications) {
    medications = initialMedications;
  }

  @override
  Future<void> loadMedications() async {
    isLoading = false;
    notifyListeners();
  }
}

Widget createMedicationListTestApp(MedicationListModel model) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<MedicationListModel>.value(value: model),
      ChangeNotifierProvider(create: (_) => ReminderTimeModel()),
    ],
    child: MaterialApp(
      routes: {
        '/medication_page': (_) => const Scaffold(),
      },
      home: const MedicationListPage(),
    ),
  );
}

Medication createMedication(String name) {
  return Medication(
    id: 1,
    name: name,
    intakes: [
      MedicationIntakeModel(
        dayPart: 'morning',
        amount: 1.0,
        reminder: true,
      ),
    ],
  );
}

void main() {
  testWidgets('MedicationList rendert n Items', (tester) async {
    final model = FakeMedicationListModel([
      createMedication('Ibuprofen'),
      createMedication('Paracetamol'),
    ]);

    await tester.pumpWidget(createMedicationListTestApp(model));
    await tester.pump();

    expect(find.text('Ibuprofen'), findsOneWidget);
    expect(find.text('Paracetamol'), findsOneWidget);
    expect(find.text('Noch keine Medikamente vorhanden'), findsNothing);
  });

  testWidgets('MedicationList zeigt Empty-State', (tester) async {
    final model = FakeMedicationListModel([]);

    await tester.pumpWidget(createMedicationListTestApp(model));
    await tester.pump();

    expect(find.text('Noch keine Medikamente vorhanden'), findsOneWidget);
  });
}