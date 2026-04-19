import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CalculatorButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}