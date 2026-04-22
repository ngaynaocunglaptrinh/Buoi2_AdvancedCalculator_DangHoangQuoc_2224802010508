import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buoi2danghoangquoc/providers/calculator_provider.dart';
import 'package:buoi2danghoangquoc/providers/theme_provider.dart';
import 'package:buoi2danghoangquoc/providers/history_provider.dart';
import 'package:buoi2danghoangquoc/screens/calculator_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      themeMode: themeProvider.themeMode,
      home: const CalculatorScreen(),
    );
  }
}