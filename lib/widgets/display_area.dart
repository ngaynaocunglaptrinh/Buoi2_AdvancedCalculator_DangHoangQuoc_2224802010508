import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';

class DisplayArea extends StatelessWidget {
  const DisplayArea({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(provider.expression, style: const TextStyle(fontSize: 32)),
          ),
          const SizedBox(height: 8),
          Text(
              provider.result,
              style: TextStyle(fontSize: 24, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5))
          ),
        ],
      ),
    );
  }
}