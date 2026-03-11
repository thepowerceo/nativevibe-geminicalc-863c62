import 'package:flutter/material.dart';
import 'package:gemini_calc/config/routes.dart';
import 'package:gemini_calc/providers/calculator_provider.dart';
import 'package:gemini_calc/providers/theme_provider.dart';
import 'package:gemini_calc/services/storage_service.dart';
import 'package:gemini_calc/theme/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ensure Flutter binding is initialized for async operations in main.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  final storageService = StorageService();
  await storageService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(storageService)..loadTheme(),
        ),
        ChangeNotifierProvider(
          create: (_) => CalculatorProvider(storageService)..loadHistory(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          title: 'GeminiCalc',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          routerConfig: router,
        );
      },
    );
  }
}