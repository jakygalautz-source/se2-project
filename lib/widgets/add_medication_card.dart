import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/my_card.dart';

class AddMedicationCard extends StatefulWidget {
  const AddMedicationCard({super.key});

  @override
  State<AddMedicationCard> createState() => _AddMedicationCardState();
}

class _AddMedicationCardState extends State<AddMedicationCard> {
  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isNavigating
          ? null
          : () async {
              setState(() => _isNavigating = true);

              await Navigator.pushNamed(context, '/medication_page');

              if (mounted) {
                setState(() => _isNavigating = false);
              }
            },
      child: MyCard(
        color: const Color(0xFF3F6FD9),
        child: Row(
          children: [
            _isNavigating
                ? const SizedBox(
                    height: 26,
                    width: 26,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(
                    Icons.add,
                    color: Color.fromARGB(255, 8, 42, 69),
                    size: 30,
                  ),

            const SizedBox(width: 10),

            Text(
              "Neues Medikament",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
