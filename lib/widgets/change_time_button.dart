import 'package:flutter/material.dart';

class ChangeTimeButton extends StatelessWidget {
  final VoidCallback onTap;

  const ChangeTimeButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 155, 233, 209),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        elevation: 2,
      ),
      onPressed: () {
        // hier wird später gespeichert
      },
      child: Row(
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
