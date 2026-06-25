import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pill_pilot/models/medication_list_model.dart';
import 'package:pill_pilot/models/reminder_time_model.dart';
import 'package:pill_pilot/pages/home_page.dart';
import 'package:provider/provider.dart';

Widget createLayoutTestApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ReminderTimeModel()),
      ChangeNotifierProvider(create: (_) => MedicationListModel()),
    ],
    child: const MaterialApp(
      home: HomePage(),
    ),
  );
}

Future<void> pumpHomePageWithSize(
  WidgetTester tester,
  Size size,
) async {
  await tester.binding.setSurfaceSize(size);

  addTearDown(() async {
    await tester.binding.setSurfaceSize(null);
  });

  await tester.pumpWidget(createLayoutTestApp());
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Layout funktioniert auf kleinem Display 360x640', (tester) async {
    await pumpHomePageWithSize(
      tester,
      const Size(360, 640),
    );

    expect(find.byType(HomePage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Layout funktioniert auf grossem Display 1080x1920', (tester) async {
    await pumpHomePageWithSize(
      tester,
      const Size(1080, 1920),
    );

    expect(find.byType(HomePage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}