
import 'package:flutter_test/flutter_test.dart';
import 'package:buoi2danghoangquoc/utils/expression_parser.dart';

void main() {
  group('Calculator Logic Tests', () {
    test('Basic arithmetic operations', () {
      expect(ExpressionParser.evaluate('5 + 3'), 8.0);
      expect(ExpressionParser.evaluate('10 - 4'), 6.0);
      expect(ExpressionParser.evaluate('6 * 7'), 42.0);
      expect(ExpressionParser.evaluate('15 / 3'), 5.0);
    });
    test('Order of operations', () {
      expect(ExpressionParser.evaluate('2 + 3 * 4'), 14.0);
      expect(ExpressionParser.evaluate('(2 + 3) * 4'), 20.0);
    });
    test('Complex arithmetic', () {
      expect(ExpressionParser.evaluate('(5 + 3) * 2 - 4 / 2'), 14.0);
    });
    test('Nested parentheses', () {
      expect(ExpressionParser.evaluate('((2 + 3) * (4 - 1)) / 5'), 3.0);
    });
  });
}