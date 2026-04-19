class CalculatorLogic {
  static String decToBin(String dec) => int.tryParse(dec)?.toRadixString(2) ?? "0";
  static String decToHex(String dec) => int.tryParse(dec)?.toRadixString(16).toUpperCase() ?? "0";
}