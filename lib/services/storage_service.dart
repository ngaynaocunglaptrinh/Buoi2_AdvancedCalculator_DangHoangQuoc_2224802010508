import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/calculation_history.dart';

class StorageService {
  static const String _historyKey = 'calc_history';

  Future<void> saveHistory(List<CalculationHistory> history) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(history.map((e) => e.toJson()).toList());
    await prefs.setString(_historyKey, encodedData);
  }

  Future<List<CalculationHistory>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_historyKey);
    if (data == null) return [];
    final List decoded = jsonDecode(data);
    return decoded.map((e) => CalculationHistory.fromJson(e)).toList();
  }
}