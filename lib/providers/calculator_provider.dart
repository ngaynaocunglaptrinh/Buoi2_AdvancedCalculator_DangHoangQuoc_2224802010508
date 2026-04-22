import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:buoi2danghoangquoc/models/calculator_mode.dart';

class CalculatorProvider extends ChangeNotifier {
  String _expression = '';
  String _result = '0';
  CalculatorMode _mode = CalculatorMode.basic;
  AngleMode _angleMode = AngleMode.degrees;
  int _precision = 2;
  double _memory = 0;

  String get expression => _expression;
  String get result => _result;
  CalculatorMode get mode => _mode;
  AngleMode get angleMode => _angleMode;
  int get precision => _precision;

  void updatePrecision(int v) { _precision = v; notifyListeners(); }
  void toggleAngleMode(AngleMode m) { _angleMode = m; notifyListeners(); }
  void toggleMode(CalculatorMode m) { _mode = m; notifyListeners(); }

  // Memory Logic
  void memoryAdd() { _memory += double.tryParse(_result) ?? 0; notifyListeners(); }
  void memorySubtract() { _memory -= double.tryParse(_result) ?? 0; notifyListeners(); }
  void memoryClear() { _memory = 0; notifyListeners(); }
  void memoryRecall() { _expression += _memory.toString(); notifyListeners(); }

  void calculate() {
    if (_expression.isEmpty) return;
    try {
      String expStr = _expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('π', '3.141592653589793')
          .replaceAll('e', '2.718281828459');

      Parser p = Parser();
      Expression exp = p.parse(expStr);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      // xóa số thập phân ,00
      if (eval == eval.toInt()) {
        _result = eval.toInt().toString();
      } else {

        _result = eval.toStringAsFixed(_precision);


        _result = _result.replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
      }

    } catch (e) {
      _result = "Error";
    }
    notifyListeners();
  }

  void addToExpression(String val) { _expression += val; notifyListeners(); }
  void clear() { _expression = ''; _result = '0'; notifyListeners(); }
  void deleteLast() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      notifyListeners();
    }
  }
}