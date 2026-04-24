import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).cardColor,
          foregroundColor: textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}