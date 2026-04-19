import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../models/calculator_mode.dart';

class ModeSelector extends StatelessWidget {
  const ModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildModeBtn(context, "Basic", CalculatorMode.basic, provider),
        _buildModeBtn(context, "Scientific", CalculatorMode.scientific, provider),
        _buildModeBtn(context, "Programmer", CalculatorMode.programmer, provider),
      ],
    );
  }

  Widget _buildModeBtn(BuildContext context, String title, CalculatorMode mode, CalculatorProvider p) {
    return TextButton(
      onPressed: () => p.toggleMode(mode),
      child: Text(title, style: TextStyle(color: p.mode == mode ? Colors.blue : Colors.grey)),
    );
  }
}