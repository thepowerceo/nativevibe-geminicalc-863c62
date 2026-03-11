import 'package:flutter/material.dart';
import 'package:gemini_calc/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSelector extends StatelessWidget {
  ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SegmentedButton<ThemeMode>(
        segments: const <ButtonSegment<ThemeMode>>[
          ButtonSegment<ThemeMode>(
            value: ThemeMode.light,
            icon: Icon(Icons.wb_sunny_outlined),
            label: Text('Light'),
          ),
          ButtonSegment<ThemeMode>(
            value: ThemeMode.dark,
            icon: Icon(Icons.nightlight_outlined),
            label: Text('Dark'),
          ),
          ButtonSegment<ThemeMode>(
            value: ThemeMode.system,
            icon: Icon(Icons.settings_suggest_outlined),
            label: Text('System'),
          ),
        ],
        selected: <ThemeMode>{themeProvider.themeMode},
        onSelectionChanged: (Set<ThemeMode> newSelection) {
          themeProvider.setThemeMode(newSelection.first);
        },
        showSelectedIcon: false,
        style: SegmentedButton.styleFrom(
          fixedSize: const Size.fromHeight(40),
        ),
      ),
    );
  }
}