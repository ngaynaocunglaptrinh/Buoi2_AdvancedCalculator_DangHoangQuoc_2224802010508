import 'package:math_expressions/math_expressions.dart';

class ExpressionParser {
  static double evaluate(String expression) {
    try {
      String finalExp = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('π', '3.141592653589793');
      Parser p = Parser();
      Expression exp = p.parse(finalExp);
      ContextModel cm = ContextModel();
      return exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      throw Exception("Invalid Expression");
    }
  }
}