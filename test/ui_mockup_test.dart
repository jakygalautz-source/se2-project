import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pill_pilot/pages/login_page.dart';
import 'package:pill_pilot/pages/register_page.dart';

void main() {
  testWidgets('LoginScreen kann als UI Mockup gerendert werden', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));

    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('RegisterScreen kann als UI Mockup gerendert werden', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));

    await tester.pumpWidget(
      const MaterialApp(
        home: RegisterPage(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(RegisterPage), findsOneWidget);
  });
}