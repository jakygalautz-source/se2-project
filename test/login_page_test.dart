import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pill_pilot/pages/login_page.dart';

void main() {
  testWidgets('LoginForm zeigt Fehlermeldung bei leeren Feldern', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    await tester.tap(find.text('Einloggen'));
    await tester.pump();

    expect(
      find.text('Bitte E-Mail-Adresse und Passwort eingeben'),
      findsOneWidget,
    );
  });
}