import 'package:flutter/material.dart';
import 'package:gemini_calc/providers/calculator_provider.dart';
import 'package:gemini_calc/widgets/settings_group.dart';
import 'package:gemini_calc/widgets/theme_selector.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  void _showClearHistoryDialog(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Clear History?'),
          content: const Text('This will permanently delete all calculation history. This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            FilledButton.tonal(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                
              ),
              child: const Text('Clear'),
              onPressed: () {
                provider.clearHistory();
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('History cleared.'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SettingsGroup(
            title: 'Appearance',
            children: [ThemeSelector()],
          ),
          const SizedBox(height: 24),
          SettingsGroup(
            title: 'Data Management',
            children: [
              ListTile(
                title: const Text('Clear Calculation History'),
                subtitle: const Text('Removes all saved calculations.'),
                leading: const Icon(Icons.delete_sweep_outlined),
                onTap: () => _showClearHistoryDialog(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}