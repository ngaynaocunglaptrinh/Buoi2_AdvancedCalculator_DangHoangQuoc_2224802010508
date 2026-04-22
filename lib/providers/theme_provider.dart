import 'package:flutter/material.dart';
import 'package:buoi2danghoangquoc/utils/constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.bgLight,
    cardColor: AppColors.btnNumberLight,
    colorScheme: const ColorScheme.light(
      primary: AppColors.btnOperatorLight,
      secondary: AppColors.btnOperatorLight,
    ),
  );

  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bgDark,
    cardColor: AppColors.btnNumberDark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.btnOperatorDark,
      secondary: AppColors.btnOperatorDark,
    ),
  );

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}