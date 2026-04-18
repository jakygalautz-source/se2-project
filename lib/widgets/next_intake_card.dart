import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/my_card.dart';
import 'package:pill_pilot/models/next_intake_model.dart';

class NextIntakeCard extends StatelessWidget {
  final NextIntakeModel? nextIntake;

  const NextIntakeCard({super.key, required this.nextIntake});

  @override
  Widget build(BuildContext context) {
    final next = nextIntake;

    return MyCard(
      color: Color(0xFFE8F0FF),
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
                child: Icon(
                  next?.hasActiveReminder == true
                      ? Icons.notifications_active_outlined
                      : Icons.notifications_outlined,
                  size: 35,
                ),
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
                    next?.title ?? "Keine Einnahme geplant",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    next?.subtitle ?? "Keine Daten verfügbar",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 64, 64, 64),
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
