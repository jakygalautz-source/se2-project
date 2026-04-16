import 'package:flutter/material.dart';
import 'package:pill_pilot/api/reminder_time_api.dart';
import 'package:pill_pilot/models/reminder_time_model.dart';
import 'package:pill_pilot/pages/home_page.dart';
import 'package:provider/provider.dart';

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
    try {
      final reminderData = await ReminderTimeApi.getReminderTimes();

      if (!mounted) return;

      context.read<ReminderTimeModel>().loadfromJson(reminderData);
    } catch (_) {
      // falls das laden nicht klappt bleiben die default zeiten drin
    }

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });
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
