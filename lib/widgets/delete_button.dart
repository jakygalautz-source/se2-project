import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback? onTap;

  const DeleteButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.delete_outline, size: 26),
      ),
    );
  }
}
