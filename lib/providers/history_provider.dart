import 'package:flutter/material.dart';
import 'package:buoi2danghoangquoc/models/calculation_history.dart';
import 'package:buoi2danghoangquoc/services/storage_service.dart';

class HistoryProvider extends ChangeNotifier {
  List<CalculationHistory> _history = [];
  final StorageService _storage = StorageService();

  List<CalculationHistory> get history => _history;

  HistoryProvider() {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    _history = await _storage.loadHistory();
    notifyListeners();
  }

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

  Future<void> clearHistory() async {
    _history.clear();
    await _storage.saveHistory(_history);
    notifyListeners();
  }
}