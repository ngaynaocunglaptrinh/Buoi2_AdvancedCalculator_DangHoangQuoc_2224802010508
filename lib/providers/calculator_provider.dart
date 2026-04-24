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
  bool _hasMemory = false;

  String get expression => _expression;
  String get result => _result;
  CalculatorMode get mode => _mode;
  AngleMode get angleMode => _angleMode;
  int get precision => _precision;
  bool get hasMemory => _hasMemory;

  void updatePrecision(int v) {
    _precision = v;
    notifyListeners();
  }

  void toggleAngleMode(AngleMode m) {
    _angleMode = m;
    notifyListeners();
  }

  void toggleMode(CalculatorMode m) {
    _mode = m;
    notifyListeners();
  }

  void memoryAdd() {
    if (_expression.isNotEmpty) calculate();
    _memory += double.tryParse(_result) ?? 0;
    _hasMemory = true;
    notifyListeners();
  }

  void memorySubtract() {
    if (_expression.isNotEmpty) calculate();
    _memory -= double.tryParse(_result) ?? 0;
    _hasMemory = true;
    notifyListeners();
  }

  void memoryClear() {
    _memory = 0;
    _hasMemory = false;
    notifyListeners();
  }

  void memoryRecall() {
    String memStr = (_memory == _memory.toInt())
        ? _memory.toInt().toString()
        : _memory.toString();
    _expression = memStr;
    _result = memStr;
    notifyListeners();
  }

  void convertBase(String base) {
    try {
      int val = int.tryParse(_result) ?? int.parse(_result, radix: 16);
      if (base == 'BIN') _result = val.toRadixString(2);
      else if (base == 'HEX') _result = val.toRadixString(16).toUpperCase();
      else if (base == 'OCT') _result = val.toRadixString(8);
      else if (base == 'DEC') _result = val.toString();
      notifyListeners();
    } catch (e) {
      _result = "Error";
      notifyListeners();
    }
  }

  void calculate() {
    if (_expression.isEmpty) return;

    if (_mode == CalculatorMode.programmer) {
      try {
        String expr = _expression;
        String op = '';
        if (expr.contains('AND')) op = 'AND';
        else if (expr.contains('OR')) op = 'OR';
        else if (expr.contains('XOR')) op = 'XOR';
        else if (expr.contains('<<')) op = '<<';

        if (op.isNotEmpty) {
          List<String> parts = expr.split(op);
          if (parts.length == 2) {
            int v1 = int.parse(parts[0], radix: 16);
            int v2 = int.parse(parts[1], radix: 16);
            int res = 0;

            if (op == 'AND') res = v1 & v2;
            if (op == 'OR') res = v1 | v2;
            if (op == 'XOR') res = v1 ^ v2;
            if (op == '<<') res = v1 << v2;

            _result = res.toRadixString(16).toUpperCase();
            notifyListeners();
            return;
          }
        } else {
          int val = int.parse(expr, radix: 16);
          _result = val.toRadixString(16).toUpperCase();
          notifyListeners();
          return;
        }
      } catch (e) {
        _result = "Error";
        notifyListeners();
        return;
      }
    }

    try {
      String expStr = _expression
          .replaceAll(RegExp(r'(\d)π'), r'$1*3.141592653589793')
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('π', '3.141592653589793')
          .replaceAll('e', '2.718281828459')
          .replaceAll('√', 'sqrt');

      if (_angleMode == AngleMode.degrees) {
        expStr = expStr.replaceAllMapped(RegExp(r'(sin|cos|tan)\(([^)]+)\)'), (match) {
          return '${match[1]}((${match[2]}) * 3.141592653589793 / 180)';
        });
      }

      Parser p = Parser();
      Expression exp = p.parse(expStr);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

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

  void addToExpression(String val) {
    _expression += val;
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
}