import 'package:flutter/material.dart';
import 'package:pill_pilot/models/reminder_time_model.dart';
import 'package:pill_pilot/api/reminder_time_api.dart';
import 'package:provider/provider.dart';

class ChangeTimeButton extends StatelessWidget {
  final VoidCallback onTap;

  const ChangeTimeButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFE8F0FF),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        elevation: 2,
      ),
      onPressed: () async {
        final reminderTimeModel = context.read<ReminderTimeModel>();
        final navigator = Navigator.of(context);

        try {
          final data = await ReminderTimeApi.getReminderTimes();
          reminderTimeModel.loadFromJson(data);
        } catch (_) {
          // fallback → default Zeiten bleiben
        }

        if (!context.mounted) return;

        await navigator.pushNamed('/reminder_time_page');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("lib/images/time.png", height: 30),
          const SizedBox(width: 10),
          Text(
            "Zeiten anpassen",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
