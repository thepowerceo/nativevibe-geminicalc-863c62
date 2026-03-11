import 'package:flutter/material.dart';
import 'package:gemini_calc/providers/calculator_provider.dart';
import 'package:provider/provider.dart';

class CalculatorDisplay extends StatelessWidget {
  CalculatorDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final calculator = context.watch<CalculatorProvider>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Expression
          SizedBox(
            height: 40,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: Text(
                calculator.expression,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Result
          SizedBox(
            height: 60,
            child: FittedBox(
              fit: BoxFit.contain,
              alignment: Alignment.centerRight,
              child: Text(
                calculator.result.isEmpty ? '0' : calculator.result,
                style: theme.textTheme.displayLarge,
                textAlign: TextAlign.right,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}