import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/my_card.dart';

class ChangeTimeCard extends StatelessWidget {
  const ChangeTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MyCard(
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
    );
  }
}
