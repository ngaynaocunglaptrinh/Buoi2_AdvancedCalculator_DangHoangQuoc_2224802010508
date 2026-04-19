import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/history_provider.dart';
import '../models/calculator_mode.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final calcProvider = Provider.of<CalculatorProvider>(context);
    final historyProvider = Provider.of<HistoryProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text('Theme Mode'),
            trailing: DropdownButton<ThemeMode>(
              value: themeProvider.themeMode,
              onChanged: (mode) => themeProvider.setTheme(mode!),
              items: const [
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
                DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
              ],
            ),
          ),
          ListTile(
            title: const Text('Decimal Precision'),
            subtitle: Slider(
              value: calcProvider.precision.toDouble(),
              min: 2, max: 10, divisions: 8,
              onChanged: (val) => calcProvider.updatePrecision(val.toInt()),
            ),
          ),
          SwitchListTile(
            title: const Text('Use Radians'),
            value: calcProvider.angleMode == AngleMode.radians,
            onChanged: (val) => calcProvider.toggleAngleMode(val ? AngleMode.radians : AngleMode.degrees),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => historyProvider.clearHistory(),
            child: const Text('Clear All History', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}