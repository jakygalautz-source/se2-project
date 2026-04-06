import 'package:flutter/material.dart';
import 'package:pill_pilot/models/medication_model.dart';
import 'package:pill_pilot/widgets/my_card.dart';

class MyMedicationListCard extends StatelessWidget {
  final Medication medication;
  final VoidCallback? onTap;

  const MyMedicationListCard({super.key, required this.medication, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/medication_page'),
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
                const Icon(Icons.edit_outlined, size: 22),
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
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        '${_formatAmount(intake.amount)} ${_getUnitText(intake.amount)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        intake.reminder ? 'Erinnerung an' : 'Erinnerung aus',
                        style: Theme.of(context).textTheme.bodyMedium,
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
