import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/my_card.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MyCard(
      border: Border.all(color: Colors.black, width: 1),
      child: Row(
        children: [
          Icon(Icons.settings_outlined, color: Colors.black),
          SizedBox(width: 10),
          Text(
            "Profileinstellungen",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
