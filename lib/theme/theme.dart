import 'package:flutter/material.dart';
import 'package:gemini_calc/theme/color_schemes.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      textTheme: GoogleFonts.orbitronTextTheme(
        ThemeData.light().textTheme,
      ).copyWith(
        displayLarge: GoogleFonts.orbitron(color: lightColorScheme.onSurface, fontSize: 52, fontWeight: FontWeight.bold),
        headlineSmall: GoogleFonts.orbitron(color: lightColorScheme.onSurface, fontWeight: FontWeight.w600),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: lightColorScheme.surfaceContainerHighest,
        
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.2),
        centerTitle: true,
      ),
      scaffoldBackgroundColor: lightColorScheme.surface,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        color: lightColorScheme.surfaceContainerHighest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: lightColorScheme.outlineVariant),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      textTheme: GoogleFonts.orbitronTextTheme(
        ThemeData.dark().textTheme,
      ).copyWith(
        displayLarge: GoogleFonts.orbitron(color: darkColorScheme.onSurface, fontSize: 52, fontWeight: FontWeight.bold),
        headlineSmall: GoogleFonts.orbitron(color: darkColorScheme.onSurface, fontWeight: FontWeight.w600),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkColorScheme.surfaceContainerHighest,
        
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.5),
        centerTitle: true,
      ),
      scaffoldBackgroundColor: darkColorScheme.surface,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 1,
        color: darkColorScheme.surfaceContainerHighest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: darkColorScheme.outline),
        ),
      ),
    );
  }
}