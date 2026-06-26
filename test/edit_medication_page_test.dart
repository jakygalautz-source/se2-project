import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:pill_pilot/pages/medication_page.dart';
import 'package:pill_pilot/models/intake_slot_model.dart';
import 'package:pill_pilot/models/medication_form_model.dart';
import 'package:pill_pilot/models/medication_list_model.dart';
import 'package:pill_pilot/models/reminder_time_model.dart';
import 'package:pill_pilot/models/medication_model.dart';
import 'package:pill_pilot/models/medication_intake_model.dart';

Widget createEditMedicationTestApp(Medication medication) {
  final intakeSlotModel = IntakeSlotModel();

  return MultiProvider(
    providers: [
      ChangeNotifierProvider<IntakeSlotModel>.value(value: intakeSlotModel),
      ChangeNotifierProvider(
        create: (_) => MedicationFormModel(intakeSlotModel: intakeSlotModel),
      ),
      ChangeNotifierProvider(create: (_) => MedicationListModel()),
      ChangeNotifierProvider(create: (_) => ReminderTimeModel()),
    ],
    child: MaterialApp(
      home: MedicationPage(
        isEditMode: true,
        medication: medication,
      ),
    ),
  );
}

void main() {
  testWidgets('EditForm ist mit aktuellen Werten vorausgefuellt', (tester) async {
    final medication = Medication(
      id: 1,
      name: 'Ibuprofen',
      intakes: [
        MedicationIntakeModel(
          dayPart: 'morning',
          amount: 1.0,
          reminder: true,
        ),
      ],
    );

    await tester.binding.setSurfaceSize(const Size(430, 932));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(createEditMedicationTestApp(medication));
    await tester.pump();

    expect(find.text('Medikament bearbeiten'), findsOneWidget);
    expect(find.text('Ibuprofen'), findsOneWidget);
    expect(find.text('Morgens'), findsWidgets);
  });
}