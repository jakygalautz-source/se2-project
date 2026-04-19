import 'package:flutter/material.dart';

class ReminderToggleButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onTap;
  const ReminderToggleButton({
    required this.isEnabled,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(microseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isEnabled
              ? Colors.yellowAccent.shade100
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            if (isEnabled)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isEnabled
                  ? Icons.notifications_outlined
                  : Icons.notifications_off_outlined,
              color: isEnabled ? Colors.white : Colors.black54,
              size: 20,
            ),
            const SizedBox(width: 6),
            Text(
              isEnabled ? "Erinnerung ein" : "Erinnerung aus",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
