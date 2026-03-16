import 'package:flutter/material.dart';
import 'package:gemini_calc/providers/calculator_provider.dart';
import 'package:gemini_calc/widgets/calculator_button.dart';
import 'package:gemini_calc/widgets/calculator_display.dart';
import 'package:provider/provider.dart';

class CalculatorLayout extends StatelessWidget {
  CalculatorLayout({super.key});

  final List<List<Map<String, dynamic>>> buttonRows = [
    [
      {'label': 'AC', 'type': ButtonType.action},
      {'label': 'C', 'type': ButtonType.action},
      {'label': 'â«', 'type': ButtonType.action},
      {'label': 'Ã·', 'type': ButtonType.operator},
    ],
    [
      {'label': 'sin', 'type': ButtonType.function},
      {'label': 'cos', 'type': ButtonType.function},
      {'label': 'tan', 'type': ButtonType.function},
      {'label': 'Ã', 'type': ButtonType.operator},
    ],
    [
      {'label': '7', 'type': ButtonType.number},
      {'label': '8', 'type': ButtonType.number},
      {'label': '9', 'type': ButtonType.number},
      {'label': '-', 'type': ButtonType.operator},
    ],
    [
      {'label': '4', 'type': ButtonType.number},
      {'label': '5', 'type': ButtonType.number},
      {'label': '6', 'type': ButtonType.number},
      {'label': '+', 'type': ButtonType.operator},
    ],
    [
      {'label': '1', 'type': ButtonType.number},
      {'label': '2', 'type': ButtonType.number},
      {'label': '3', 'type': ButtonType.number},
      {'label': '=', 'type': ButtonType.operator, 'flex': 1},
    ],
    [
      {'label': '%', 'type': ButtonType.number},
      {'label': '0', 'type': ButtonType.number},
      {'label': '.', 'type': ButtonType.number},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final calculator = Provider.of<CalculatorProvider>(context, listen: false);

    return Column(
      children: [
        CalculatorDisplay(),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: buttonRows.map((row) {
              // Handle the special case for the '=' button row
              if (row.any((btn) => btn['label'] == '=')) {
                return Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: row
                            .where((btn) => btn['label'] != '=')
                            .map((buttonConfig) {
                          return CalculatorButton(
                            label: buttonConfig['label'],
                            onPressed: () => calculator.onButtonPressed(buttonConfig['label']),
                            type: buttonConfig['type'],
                            flex: buttonConfig['flex'] ?? 1,
                          );
                        }).toList(),
                      ),
                    ),
                    CalculatorButton(
                      label: '=',
                      onPressed: () => calculator.onButtonPressed('='),
                      type: ButtonType.operator,
                      flex: 1,
                    ),
                  ],
                );
              }

              return Row(
                children: row.map((buttonConfig) {
                  return CalculatorButton(
                    label: buttonConfig['label'],
                    onPressed: () => calculator.onButtonPressed(buttonConfig['label']),
                    type: buttonConfig['type'],
                    flex: buttonConfig['flex'] ?? 1,
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}