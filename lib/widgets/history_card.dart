import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/my_card.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MyCard(
      border: Border.all(color: Colors.black, width: 1),
      child: Row(
        children: [
          Icon(Icons.history, color: Colors.black),
          SizedBox(width: 10),
          Text(
            "Einnahmeverlauf",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
