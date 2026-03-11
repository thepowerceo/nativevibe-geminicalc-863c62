import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gemini_calc/models/calculation_history.dart';
import 'package:intl/intl.dart';

class HistoryListItem extends StatelessWidget {
  final CalculationHistory historyEntry;

  HistoryListItem({super.key, required this.historyEntry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedTime = DateFormat.yMMMd().add_jm().format(historyEntry.timestamp);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: () {
          // Potentially copy result to clipboard on tap
          Clipboard.setData(ClipboardData(text: historyEntry.result));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Result copied to clipboard: ${historyEntry.result}')),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      historyEntry.expression,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.8),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    formattedTime,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '= ${historyEntry.result}',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}