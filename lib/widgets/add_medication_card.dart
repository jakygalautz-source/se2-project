import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/my_card.dart';

class AddMedicationCard extends StatelessWidget {
  const AddMedicationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/medication_page'),
      child: MyCard(
        color: const Color(0xFF3F6FD9),
        child: Row(
          children: [
            Icon(Icons.add, color: Color.fromARGB(255, 8, 42, 69), size: 30),
            SizedBox(width: 10),
            Text(
              "Medikament hinzufügen",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
