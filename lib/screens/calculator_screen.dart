import 'package:flutter/material.dart';
import '../widgets/display_area.dart';
import '../widgets/button_grid.dart';
import '../widgets/mode_selector.dart';
import 'settings_screen.dart';
import 'history_screen.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.grey),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.grey),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: const [
            ModeSelector(),
            Expanded(flex: 4, child: DisplayArea()),
            Divider(height: 1, color: Colors.grey),
            Expanded(flex: 6, child: ButtonGrid()),
          ],
        ),
      ),
    );
  }
}