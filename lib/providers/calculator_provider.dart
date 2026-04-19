import 'package:flutter/material.dart';
import '../models/calculator_mode.dart';
import '../utils/expression_parser.dart';

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

  void addToExpression(String value) {
    _expression += value;
    notifyListeners();
  }

  void calculate() {
    if (_expression.isEmpty) return;
    try {
      double eval = ExpressionParser.evaluate(_expression);
      _result = eval.toStringAsFixed(_precision);
      if (_result.endsWith('0' * _precision)) {
        _result = eval.toStringAsFixed(0);
      }
    } catch (e) {
      _result = "Error";
    }
    notifyListeners();
  }

  void clear() {
    _expression = '';
    _result = '0';
    notifyListeners();
  }

  void deleteLast() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      notifyListeners();
    }
  }

  void toggleMode(CalculatorMode mode) {
    _mode = mode;
    notifyListeners();
  }

  void updatePrecision(int value) {
    _precision = value;
    notifyListeners();
  }

  void toggleAngleMode(AngleMode mode) {
    _angleMode = mode;
    notifyListeners();
  }
}