import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(secondary: AppColors.secondaryLight),
    fontFamily: 'Roboto',
  );

  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.primaryDark,
    colorScheme: const ColorScheme.dark(secondary: AppColors.secondaryDark),
    fontFamily: 'Roboto',
  );

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}