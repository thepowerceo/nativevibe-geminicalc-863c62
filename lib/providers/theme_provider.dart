import 'package:flutter/material.dart';
import 'package:gemini_calc/services/storage_service.dart';

class ThemeProvider with ChangeNotifier {
  final StorageService _storageService;

  ThemeProvider(this._storageService);

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadTheme() async {
    _themeMode = await _storageService.loadThemeMode();
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    
    _themeMode = mode;
    await _storageService.saveThemeMode(mode);
    notifyListeners();
  }
}