import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buoi2danghoangquoc/providers/calculator_provider.dart';

class DisplayArea extends StatelessWidget {
  const DisplayArea({super.key});

  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<CalculatorProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) cp.deleteLast();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: SingleChildScrollView(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (cp.hasMemory)
                const Text('M', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 18)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Text(
                  cp.expression.isEmpty ? "0" : cp.expression,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w300,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  cp.result,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white.withOpacity(0.5) : Colors.black.withOpacity(0.5),
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