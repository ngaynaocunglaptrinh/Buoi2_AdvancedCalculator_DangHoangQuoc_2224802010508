import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../widgets/display_area.dart';
import '../widgets/button_grid.dart';
import '../widgets/mode_selector.dart';
import 'settings_screen.dart';
import 'history_screen.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
        ],
      ),
      body: Column(
        children: [
          const ModeSelector(),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! > 0) provider.deleteLast();
              },
              child: const DisplayArea(),
            ),
          ),
          const Expanded(flex: 2, child: ButtonGrid()),
        ],
      ),
    );
  }
}