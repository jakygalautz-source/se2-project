import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:pill_pilot/pages/login_page.dart';
import 'package:pill_pilot/pages/home_page.dart';
import 'package:pill_pilot/models/reminder_time_model.dart';
import 'package:pill_pilot/models/medication_list_model.dart';

Widget createRouterTestApp({required String initialRoute}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ReminderTimeModel()),
      ChangeNotifierProvider(create: (_) => MedicationListModel()),
    ],
    child: MaterialApp(
      initialRoute: initialRoute,
      routes: {
        '/login_page': (context) => const LoginPage(),
        '/home_page': (context) => const HomePage(),
      },
    ),
  );
}

void main() {
  testWidgets('Router: /login_page zeigt LoginScreen', (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 932));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      createRouterTestApp(initialRoute: '/login_page'),
    );

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.text('Anmelden'), findsOneWidget);
  });

  testWidgets('Router: /home_page zeigt HomeScreen', (tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 932));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      createRouterTestApp(initialRoute: '/home_page'),
    );

    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Willkommen bei Pill Pilot'), findsOneWidget);
  });
}