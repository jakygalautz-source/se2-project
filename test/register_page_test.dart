import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pill_pilot/pages/register_page.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: RegisterPage(),
    );
  }

  testWidgets('zeigt Fehler bei leerem Pflichtfeld', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text('Speichern'));
    await tester.pump();

    expect(find.textContaining('Pflichtfelder'), findsOneWidget);
  });

  testWidgets('zeigt Fehler bei ungueltigem Email-Format', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final textFields = find.byType(TextField);

    await tester.enterText(textFields.at(0), 'Max');
    await tester.enterText(textFields.at(1), 'keine-email');
    await tester.enterText(textFields.at(2), '123456');
    await tester.enterText(textFields.at(3), '123456');

    await tester.tap(find.text('Speichern'));
    await tester.pump();

    expect(find.textContaining('E-Mail'), findsOneWidget);
  });
}