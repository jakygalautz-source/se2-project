import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/add_medication_card.dart';
import 'package:pill_pilot/widgets/history_card.dart';
import 'package:pill_pilot/widgets/my_medication_card.dart';
import 'package:pill_pilot/widgets/settings_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: isLandscape
              ? _buildLandscape(context)
              : _buildPortrait(context),
        ),
      ),
    );
  }

  Widget _buildPortrait(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset("lib/images/pills.png", height: 100),
          ),
          const SizedBox(height: 20),
          // Titel
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Willkommen bei Pill Pilot",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Ihr persönliches Pillen Navigationssystem",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 20),
          AddMedicationCard(),
          const SizedBox(height: 12),
          MyMedicationCard(),
          const SizedBox(height: 12),
          HistoryCard(),
          const SizedBox(height: 12),
          SettingsCard(),
        ],
      ),
    );
  }

  Widget _buildLandscape(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Willkommen bei Pill Pilot",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Ihr persönliches Pillen Navigationssystem",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: Image.asset("lib/images/pills.png", height: 75),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: Column(
                  children: const [
                    AddMedicationCard(),
                    SizedBox(height: 12),
                    HistoryCard(),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    MyMedicationCard(),
                    SizedBox(height: 12),
                    SettingsCard(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
