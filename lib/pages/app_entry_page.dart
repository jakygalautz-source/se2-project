import 'package:flutter/material.dart';
import 'package:pill_pilot/api/reminder_time_api.dart';
import 'package:pill_pilot/models/reminder_time_model.dart';
import 'package:pill_pilot/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:pill_pilot/services/notifications_service.dart';
import 'package:pill_pilot/models/medication_list_model.dart';

class AppEntryPage extends StatefulWidget {
  const AppEntryPage({super.key});

  @override
  State<AppEntryPage> createState() => _AppEntryPageState();
}

class _AppEntryPageState extends State<AppEntryPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final reminderTimeModel = context.read<ReminderTimeModel>();
    final medicationListModel = context.read<MedicationListModel>();

    await NotificationsService.instance.init();
    await NotificationsService.instance.requestPermissions();
    await NotificationsService.instance.requestExactAlarmPermission();

    // optional zum testen
    // await NotificationsService.instance.showTestNotification();

    try {
      final reminderData = await ReminderTimeApi.getReminderTimes();
      reminderTimeModel.loadFromJson(reminderData);
    } catch (_) {}

    try {
      await medicationListModel.loadMedications();
    } catch (_) {}

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    try {
      await NotificationsService.instance.rescheduleFromCurrentData(
        reminderTimeModel: reminderTimeModel,
        medications: medicationListModel.medications,
      );
    } catch (e, st) {
      debugPrint("Initial reminder scheduling failed: $e");
      debugPrintStack(stackTrace: st);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: SafeArea(child: Center(child: CircularProgressIndicator())),
      );
    }
    return const HomePage();
  }
}
