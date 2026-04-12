import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/my_card.dart';
import 'package:pill_pilot/models/reminder_time_model.dart';
import 'package:pill_pilot/api/reminder_time_api.dart';
import 'package:provider/provider.dart';

class ChangeTimeCard extends StatelessWidget {
  const ChangeTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
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
      child: MyCard(
        border: Border.all(color: Colors.black, width: 1),
        child: Row(
          children: [
            Image.asset("lib/images/time.png", height: 30),
            SizedBox(width: 10),
            Text(
              "Einnahmezeiten einstellen",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
