import 'package:flutter/material.dart';

class PillAddButton extends StatelessWidget {
  final VoidCallback onAddFull;
  final VoidCallback onAddHalf;

  const PillAddButton({
    super.key,
    required this.onAddFull,
    required this.onAddHalf,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 155, 233, 209),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 24, 227, 166),
              borderRadius: BorderRadius.circular(20),
            ),
            child: GestureDetector(
              onTap: () => onAddFull(),
              child: Row(
                children: [
                  Image.asset("lib/images/pill.png", height: 40),
                  const SizedBox(width: 3),
                  Text("+1", style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onAddHalf(),
            child: Row(
              children: [
                const SizedBox(width: 6),
                Image.asset("lib/images/open-pill.png", height: 48),
                Text("+½", style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
