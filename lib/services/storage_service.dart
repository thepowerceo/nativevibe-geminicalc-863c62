import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gemini_calc/models/calculation_history.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service for persisting app data using SharedPreferences.
class StorageService {
  static const _themeKey = 'theme_mode';
  static const _historyKey = 'calculation_history';

  late SharedPreferences _prefs;

  /// Initializes the storage service. Must be called before use.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // --- Theme Persistence ---

  Future<void> saveThemeMode(ThemeMode themeMode) async {
    await _prefs.setString(_themeKey, themeMode.name);
  }

  Future<ThemeMode> loadThemeMode() async {
    final themeName = _prefs.getString(_themeKey);
    return ThemeMode.values.firstWhere(
      (e) => e.name == themeName,
      orElse: () => ThemeMode.system, // Default value
    );
  }

  // --- History Persistence ---

  Future<void> saveHistory(List<CalculationHistory> history) async {
    final List<String> historyJson = history
        .map((entry) => json.encode(entry.toJson()))
        .toList();
    await _prefs.setStringList(_historyKey, historyJson);
  }

  Future<List<CalculationHistory>> loadHistory() async {
    final historyJson = _prefs.getStringList(_historyKey);
    if (historyJson == null) {
      return [];
    }

    return historyJson
        .map((entryStr) => CalculationHistory.fromJson(json.decode(entryStr)))
        .toList();
  }
}