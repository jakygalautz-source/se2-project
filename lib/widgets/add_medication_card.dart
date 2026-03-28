import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/my_card.dart';

class AddMedicationCard extends StatelessWidget {
  const AddMedicationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MyCard(
      color: const Color.fromARGB(255, 24, 227, 166),
      child: Row(
        children: [
          Icon(Icons.add, color: Colors.black),
          SizedBox(width: 10),
          Text(
            "Medikament hinzufügen",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
