import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/history_provider.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: ListView.builder(
        itemCount: historyProvider.history.length,
        itemBuilder: (context, index) {
          final item = historyProvider.history[index];
          return ListTile(
            title: Text(item.expression),
            subtitle: Text(item.result),
            trailing: Text(DateFormat('HH:mm').format(item.timestamp)),
          );
        },
      ),
    );
  }
}