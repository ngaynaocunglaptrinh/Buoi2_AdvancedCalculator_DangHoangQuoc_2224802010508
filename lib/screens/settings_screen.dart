import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/theme_provider.dart';
import '../models/calculator_mode.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cp = Provider.of<CalculatorProvider>(context);
    final tp = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text('Theme Mode'),
            trailing: DropdownButton<ThemeMode>(
              value: tp.themeMode,
              onChanged: (mode) => tp.setTheme(mode!),
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
              value: cp.precision.toDouble(),
              min: 0,
              max: 10,
              divisions: 10,
              label: cp.precision.toString(),
              onChanged: (val) => cp.updatePrecision(val.toInt()),
            ),
            trailing: Text(cp.precision.toString()),
          ),
          ListTile(
            title: const Text('Angle Mode'),
            trailing: ToggleButtons(
              isSelected: [cp.angleMode == AngleMode.degrees, cp.angleMode == AngleMode.radians],
              onPressed: (index) => cp.toggleAngleMode(index == 0 ? AngleMode.degrees : AngleMode.radians),
              children: const [Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('DEG')), Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('RAD'))],
            ),
          ),
        ],
      ),
    );
  }
}