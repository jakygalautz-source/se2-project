import 'package:flutter/material.dart';

class PillRemoveButton extends StatelessWidget {
  final VoidCallback onRemoveFull;
  final VoidCallback onRemoveHalf;

  final bool canRemoveFull;
  final bool canRemoveHalf;

  const PillRemoveButton({
    super.key,
    required this.onRemoveFull,
    required this.onRemoveHalf,
    required this.canRemoveFull,
    required this.canRemoveHalf,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: (canRemoveFull || canRemoveHalf)
            ? Colors.redAccent.shade100
            : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildHalfButton(
              context,
              label: "-1",
              imagePath: "lib/images/pill.png",
              onTap: canRemoveFull ? onRemoveFull : null,
              backgroundColor: canRemoveFull
                  ? Colors.redAccent
                  : Colors.grey.shade400,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _buildHalfButton(
              context,
              label: "-½",
              imagePath: "lib/images/open-pill.png",
              onTap: canRemoveHalf ? onRemoveHalf : null,
              backgroundColor: canRemoveHalf
                  ? Colors.transparent
                  : Colors.grey.shade300,
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
    required VoidCallback? onTap,
    required Color backgroundColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: onTap == null ? 0.6 : 1,
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
      ),
    );
  }
}
