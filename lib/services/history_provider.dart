import 'package:flutter/material.dart';
import '../models/calculation_history.dart';
import '../services/storage_service.dart';

class HistoryProvider extends ChangeNotifier {
  List<CalculationHistory> _history = [];
  final StorageService _storage = StorageService();

  List<CalculationHistory> get history => _history;

  Future<void> addRecord(String exp, String res) async {
    _history.insert(0, CalculationHistory(
        expression: exp,
        result: res,
        timestamp: DateTime.now()
    ));
    if (_history.length > 50) _history.removeLast();
    await _storage.saveHistory(_history);
    notifyListeners();
  }

  Future<void> clearAll() async {
    _history.clear();
    await _storage.saveHistory(_history);
    notifyListeners();
  }
}