import 'package:flutter/material.dart';
import 'package:pill_pilot/models/intake_slot_model.dart';
import 'package:pill_pilot/models/reminder_time_model.dart';
import 'package:pill_pilot/widgets/delete_button.dart';
import 'package:pill_pilot/widgets/my_card.dart';
import 'package:pill_pilot/models/day_part.dart';
import 'package:pill_pilot/widgets/pill_add_button.dart';
import 'package:pill_pilot/widgets/reminder_toggle_button.dart';
import 'package:provider/provider.dart';

class IntakeSlotCard extends StatelessWidget {
  final DayPart dayPart;

  const IntakeSlotCard({super.key, required this.dayPart});

  @override
  Widget build(BuildContext context) {
    return Consumer2<IntakeSlotModel, ReminderTimeModel>(
      builder: (context, intakeSlotModel, reminderTimeModel, child) {
        final time = reminderTimeModel.getTime(dayPart);

        return MyCard(
          border: Border.all(width: 1),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    getDayPartLabel(dayPart),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    _formatTime(time),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PillAddButton(
                          onAddFull: () => intakeSlotModel.addOne(dayPart),
                          onAddHalf: () => intakeSlotModel.addHalf(dayPart),
                        ),
                        const SizedBox(height: 12),
                        ReminderToggleButton(
                          isEnabled: intakeSlotModel.isReminderEnabled(dayPart),
                          onTap: () => intakeSlotModel.toggleReminder(dayPart),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${intakeSlotModel.getAmount(dayPart)} ${intakeSlotModel.getUnitText(dayPart)}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12), //
                      DeleteButton(onTap: () => intakeSlotModel.clear(dayPart)),
                      const SizedBox(height: 4),
                      Text(
                        "Menge\nlöschen",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
