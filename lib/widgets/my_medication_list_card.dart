import 'package:flutter/material.dart';
import 'package:pill_pilot/models/medication_model.dart';
import 'package:pill_pilot/widgets/delete_button.dart';
import 'package:pill_pilot/widgets/my_card.dart';

class MyMedicationListCard extends StatelessWidget {
  final Medication medication;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const MyMedicationListCard({
    super.key,
    required this.medication,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MyCard(
        border: Border.all(width: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.medication_outlined, size: 28),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    medication.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                DeleteButton(onTap: onDelete),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),

            ...medication.intakes.map(
              (intake) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        _getDayPartLabel(intake.dayPart),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        '${_formatAmount(intake.amount)} ${_getUnitText(intake.amount)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            intake.reminder
                                ? Icons.notifications_active_outlined
                                : Icons.notifications_off_outlined,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            intake.reminder ? 'An' : 'Aus',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount == amount.toInt()) {
      return amount.toInt().toString();
    }
    return amount.toString();
  }

  String _getDayPartLabel(String dayPart) {
    switch (dayPart) {
      case 'morning':
        return 'Morgens';
      case 'noon':
        return 'Mittags';
      case 'evening':
        return 'Abends';
      case 'night':
        return 'Nachts';
      default:
        return dayPart;
    }
  }

  String _getUnitText(double amount) {
    if (amount == 1.0) {
      return 'Tablette';
    }
    return 'Tabletten';
  }
}
