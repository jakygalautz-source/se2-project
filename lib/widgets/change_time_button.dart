import 'package:flutter/material.dart';

class ChangeTimeButton extends StatefulWidget {
  final VoidCallback onTap;

  const ChangeTimeButton({super.key, required this.onTap});

  @override
  State<ChangeTimeButton> createState() => _ChangeTimeButtonState();
}

class _ChangeTimeButtonState extends State<ChangeTimeButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE8F0FF),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2,
      ),
      onPressed: _isLoading
          ? null
          : () async {
              setState(() => _isLoading = true);

              final navigator = Navigator.of(context);

              if (!context.mounted) return;

              await navigator.pushNamed('/reminder_time_page');

              if (mounted) {
                setState(() => _isLoading = false);
              }
            },
      child: _isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("lib/images/time.png", height: 30),
                const SizedBox(width: 10),
                Text(
                  "Zeiten anpassen",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
    );
  }
}
