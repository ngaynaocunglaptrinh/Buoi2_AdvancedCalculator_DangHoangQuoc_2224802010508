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


    final List<String> basicKeys = [
      'C', '(', ')', '÷',
      '7', '8', '9', '×',
      '4', '5', '6', '-',
      '1', '2', '3', '+',
      '±', '0', '.', '='
    ];

    final List<String> sciKeys = [
      'sin', 'cos', 'tan', '√', 'π',
      'MC', 'MR', 'M+', 'M-', '÷',
      '7', '8', '9', '×', '(',
      '4', '5', '6', '-', ')',
      '1', '2', '3', '+', 'x²',
      'C', '0', '.', '=', 'CE'
    ];

    final List<String> progKeys = [
      'HEX', 'DEC', 'BIN', 'OCT',
      'AND', 'OR', 'XOR', 'NOT',
      'A', 'B', 'C', '÷',
      'D', 'E', 'F', '×',
      '7', '8', '9', '-',
      '4', '5', '6', '+',
      '1', '2', '3', '=',
      'CE', '0', '<<', '±'
    ];


    List<String> currentKeys;
    int columns;
    double aspectRatio;

    if (cp.mode == CalculatorMode.scientific) {
      currentKeys = sciKeys;
      columns = 5;
      aspectRatio = 1.3;
    } else if (cp.mode == CalculatorMode.programmer) {
      currentKeys = progKeys;
      columns = 4;
      aspectRatio = 1.4;
    } else {
      currentKeys = basicKeys;
      columns = 4;
      aspectRatio = 1.1;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: aspectRatio,
        ),
        itemCount: currentKeys.length,
        itemBuilder: (context, i) {
          final label = currentKeys[i];


          Color? btnColor;
          Color txtColor = isDark ? Colors.white : Colors.black;

          if (label == '=') {
            btnColor = AppColors.btnOperatorLight;
            txtColor = Colors.white;
          } else if (['+', '-', '×', '÷', 'AND', 'OR', 'XOR', 'NOT', '<<'].contains(label)) {
            btnColor = isDark
                ? AppColors.btnOperatorDark.withOpacity(0.2)
                : AppColors.btnOperatorLight.withOpacity(0.1);
            txtColor = AppColors.btnOperatorLight;
          } else if (['C', 'CE', 'MC', 'MR', 'M+', 'M-', 'HEX', 'DEC', 'BIN', 'OCT'].contains(label)) {
            btnColor = isDark ? AppColors.btnFunctionDark : AppColors.btnFunctionLight;
          }

          return CalculatorButton(
            text: label,
            color: btnColor,
            textColor: txtColor,
            onPressed: () {

              if (label == '=') {
                cp.calculate();
                if (cp.result != "Error") {
                  hp.addRecord(cp.expression, cp.result);
                }
              } else if (label == 'C' || label == 'CE') {
                cp.clear();
              } else if (label == '±') {
                cp.addToExpression('-');
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