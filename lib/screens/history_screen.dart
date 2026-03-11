import 'package:flutter/material.dart';
import 'package:gemini_calc/providers/calculator_provider.dart';
import 'package:gemini_calc/widgets/empty_state.dart';
import 'package:gemini_calc/widgets/history_list_item.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  void _showClearConfirmationDialog(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Clear History?'),
          content: const Text('This action will permanently delete all calculation history and cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            FilledButton.tonal(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                
              ),
              onPressed: () {
                provider.clearHistory();
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('History cleared.')),
                );
              },
              child: const Text('Clear All'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('History', style: theme.textTheme.headlineSmall),
        actions: [
          Consumer<CalculatorProvider>(
            builder: (context, provider, child) {
              if (provider.history.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                icon: const Icon(Icons.delete_sweep_outlined),
                onPressed: () => _showClearConfirmationDialog(context),
                tooltip: 'Clear History',
              );
            },
          ),
        ],
      ),
      body: Consumer<CalculatorProvider>(
        builder: (context, provider, child) {
          if (provider.history.isEmpty) {
            return EmptyState(
              icon: Icons.history_toggle_off_outlined,
              message: 'No calculations yet.',
              details: 'Your recent calculations will appear here.',
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: provider.history.length,
            itemBuilder: (context, index) {
              final item = provider.history[index];
              return HistoryListItem(historyEntry: item);
            },
          );
        },
      ),
    );
  }
}