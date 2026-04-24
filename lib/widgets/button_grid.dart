import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buoi2danghoangquoc/providers/calculator_provider.dart';
import 'package:buoi2danghoangquoc/providers/history_provider.dart';
import 'package:buoi2danghoangquoc/models/calculator_mode.dart';
import 'package:buoi2danghoangquoc/utils/constants.dart';
import 'calculator_button.dart';

class ButtonGrid extends StatelessWidget {
  const ButtonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<CalculatorProvider>(context);
    final hp = Provider.of<HistoryProvider>(context, listen: false);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<String> basicKeys = ['C', '(', ')', '÷', '7', '8', '9', '×', '4', '5', '6', '-', '1', '2', '3', '+', '±', '0', '.', '='];
    final List<String> sciKeys = ['sin', 'cos', 'tan', '√', 'π', 'MC', 'MR', 'M+', 'M-', '÷', '7', '8', '9', '×', '(', '4', '5', '6', '-', ')', '1', '2', '3', '+', 'x²', 'C', '0', '.', '=', 'CE'];
    final List<String> progKeys = ['HEX', 'DEC', 'BIN', 'OCT', 'AND', 'OR', 'XOR', 'NOT', 'A', 'B', 'C', '÷', 'D', 'E', 'F', '×', '7', '8', '9', '-', '4', '5', '6', '+', '1', '2', '3', '=', 'CE', '0', '<<', '±'];

    List<String> keys;
    int columns;
    double ratio;

    if (cp.mode == CalculatorMode.scientific) {
      keys = sciKeys;
      columns = 6;
      ratio = 1.1;
    } else if (cp.mode == CalculatorMode.programmer) {
      keys = progKeys;
      columns = 4;
      ratio = 1.4;
    } else {
      keys = basicKeys;
      columns = 4;
      ratio = 1.1;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: ratio,
        ),
        itemCount: keys.length,
        itemBuilder: (context, i) {
          final label = keys[i];
          Color? btnColor;
          Color txtColor = isDark ? Colors.white : Colors.black;

          if (label == '=') {
            btnColor = isDark ? AppColors.accentDark : AppColors.accentLight;
            txtColor = Colors.white;
          } else if (['+', '-', '×', '÷'].contains(label)) {
            txtColor = isDark ? AppColors.accentDark : AppColors.accentLight;
          } else if (['C', 'CE', 'MC', 'MR', 'M+', 'M-'].contains(label)) {
            btnColor = isDark ? AppColors.secondaryDark : Color(0xFFD2D3DA);
          }

          return CalculatorButton(
            text: label,
            color: btnColor,
            textColor: txtColor,
            onPressed: () {
              if (label == '=') {
                cp.calculate();
                if (cp.result != "Error") hp.addRecord(cp.expression, cp.result);
              } else if (label == 'C' || label == 'CE') {
                cp.clear();
              } else if (['BIN', 'HEX', 'OCT', 'DEC'].contains(label)) {
                cp.convertBase(label);
              } else if (label == 'M+') {
                cp.memoryAdd();
              } else if (label == 'M-') {
                cp.memorySubtract();
              } else if (label == 'MR') {
                cp.memoryRecall();
              } else if (label == 'MC') {
                cp.memoryClear();
              } else if (label == '<<') {
                cp.deleteLast();
              } else if (['sin', 'cos', 'tan', '√'].contains(label)) {
                cp.addToExpression('$label(');
              } else {
                cp.addToExpression(label);
              }
            },
          );
        },
      ),
    );
  }
}