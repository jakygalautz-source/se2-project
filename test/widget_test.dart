import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:pill_pilot/pages/login_page.dart';

void main() {
  testWidgets('Login-Seite startet ohne Crash', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    expect(find.text('Einloggen'), findsOneWidget);
  });
}
