import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/my_card.dart';

class NextIntakeCard extends StatelessWidget {
  const NextIntakeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MyCard(
      color: const Color.fromARGB(255, 232, 248, 242),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white60,
                ),
                child: Icon(Icons.notifications_outlined, size: 35),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nächste Einnahme:",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 64, 64, 64),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Medikament xy", // TODO Medication
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "in 25 Minuten", // TODO Time
                    style: TextStyle(
                      color: const Color.fromARGB(255, 64, 64, 64),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
