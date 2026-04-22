import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buoi2danghoangquoc/providers/history_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Calculation History')),
      body: historyProvider.history.isEmpty
          ? const Center(child: Text('No history yet'))
          : ListView.builder(
        itemCount: historyProvider.history.length,
        itemBuilder: (context, index) {
          final item = historyProvider.history[index];
          return ListTile(
            title: Text(item.expression),
            subtitle: Text(item.result, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
            trailing: Text("${item.timestamp.hour}:${item.timestamp.minute}"),
          );
        },
      ),
    );
  }
}