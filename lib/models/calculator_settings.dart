import 'calculator_mode.dart';

class CalculatorSettings {
  int decimalPrecision;
  AngleMode angleMode;
  bool isDarkMode;

  CalculatorSettings({
    this.decimalPrecision = 2,
    this.angleMode = AngleMode.degrees,
    this.isDarkMode = false,
  });
}