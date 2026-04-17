import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLoading;

  const SaveButton({required this.onTap, required this.isLoading, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onTap,

      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text("Speichern", style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
