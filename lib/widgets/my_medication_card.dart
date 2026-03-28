import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/my_card.dart';

class MyMedicationCard extends StatelessWidget {
  const MyMedicationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Row(
        children: [
          Icon(Icons.local_pharmacy_outlined, color: Colors.black),
          SizedBox(width: 10),
          Text(
            "Meine Medikamente",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
