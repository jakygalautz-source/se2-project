import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Border? border;
  final List<BoxShadow>? boxShadow;

  const MyCard({
    super.key,
    required this.child,
    this.color,
    this.border,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        border: border,
        borderRadius: BorderRadius.circular(20),
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}
