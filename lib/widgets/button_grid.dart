import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import 'calculator_button.dart';

class ButtonGrid extends StatelessWidget {
  const ButtonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);
    final List<String> basicButtons = [
      'C', '(', ')', '÷',
      '7', '8', '9', '×',
      '4', '5', '6', '-',
      '1', '2', '3', '+',
      '0', '.', 'delete', '='
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: basicButtons.length,
      itemBuilder: (context, index) {
        final btn = basicButtons[index];
        return CalculatorButton(
          text: btn == 'delete' ? '⌫' : btn,
          onPressed: () {
            if (btn == '=') {
              provider.calculate();
            } else if (btn == 'C') {
              provider.clear();
            } else if (btn == 'delete') {
              provider.deleteLast();
            } else {
              provider.addToExpression(btn);
            }
          },
        );
      },
    );
  }
}