import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/my_card.dart';

class ChangeTimeCard extends StatefulWidget {
  const ChangeTimeCard({super.key});

  @override
  State<ChangeTimeCard> createState() => _ChangeTimeCardState();
}

class _ChangeTimeCardState extends State<ChangeTimeCard> {
  bool _isNavigating = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isNavigating
          ? null
          : () async {
              setState(() => _isNavigating = true);

              final navigator = Navigator.of(context);

              if (!context.mounted) return;

              await navigator.pushNamed('/reminder_time_page');

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
                : Image.asset("lib/images/time.png", height: 30),

            const SizedBox(width: 10),

            Text(
              "Erinnerungszeiten",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
