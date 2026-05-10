import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/my_card.dart';

class SettingsCard extends StatefulWidget {
  const SettingsCard({super.key});

  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isNavigating
          ? null
          : () async {
              setState(() => _isNavigating = true);

              await Navigator.pushNamed(context, '/settings_page');

              if (mounted) {
                setState(() => _isNavigating = false);
              }
            },
      child: MyCard(
        border: Border.all(color: Colors.black, width: 1),
        child: Row(
          children: [
            _isNavigating
                ? const SizedBox(
                    height: 26,
                    width: 26,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.settings_outlined, color: Colors.black),
            const SizedBox(width: 10),
            Text(
              "Profileinstellungen",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
