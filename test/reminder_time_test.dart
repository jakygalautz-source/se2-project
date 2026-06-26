import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:pill_pilot/pages/reminder_time_page.dart';
import 'package:pill_pilot/models/reminder_time_model.dart';
import 'package:pill_pilot/models/medication_list_model.dart';

Widget createReminderTimeTestApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ReminderTimeModel()),
      ChangeNotifierProvider(create: (_) => MedicationListModel()),
    ],
    child: const MaterialApp(
      home: ReminderTimePage(),
    ),
  );
}

void main() {
  testWidgets('TimePicker ist integriert', (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 932));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(createReminderTimeTestApp());

    expect(find.text('Erinnerungszeiten'), findsOneWidget);
    expect(find.text('Morgens'), findsOneWidget);
    expect(find.text('08:00'), findsOneWidget);

    await tester.tap(find.text('Morgens'));
    await tester.pumpAndSettle();

    expect(find.byType(TimePickerDialog), findsOneWidget);
  });
}