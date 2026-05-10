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
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 151, 185, 249),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildHalfButton(
              context,
              label: "+½",
              imagePath: "lib/images/open-pill.png",
              onTap: onAddHalf,
              backgroundColor: Colors.transparent,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _buildHalfButton(
              context,
              label: "+1",
              imagePath: "lib/images/pill.png",
              onTap: onAddFull,
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHalfButton(
    BuildContext context, {
    required String label,
    required String imagePath,
    required VoidCallback onTap,
    required Color backgroundColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 22),
            const SizedBox(width: 4),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
