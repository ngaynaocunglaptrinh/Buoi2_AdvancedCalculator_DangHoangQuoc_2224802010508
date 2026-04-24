import 'package:flutter/material.dart';
import 'package:buoi2danghoangquoc/utils/constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.bgLight,
    primaryColor: AppColors.primaryLight,
    cardColor: Colors.white,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      surface: AppColors.accentLight,
    ),
  );

  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bgDark,
    primaryColor: AppColors.primaryDark,
    cardColor: AppColors.secondaryDark,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      surface: AppColors.accentDark,
    ),
  );

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}