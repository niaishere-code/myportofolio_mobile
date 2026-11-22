import 'package:flutter/material.dart';

class PortfolioTheme {
  // === Palet Warna dari :root style.css ===
  static const Color ink = Color(0xFF2B1620); // --ink
  static const Color paper = Color(0xFFFFF3F6); // --paper
  static const Color card = Color(0xFFFFFFFF); // --card
  static const Color accent = Color(0xFFFF8FB1); // --accent
  static const Color accentSoft = Color(0xFFFFD9E6); // --accent-soft
  static const Color accentDark = Color(0xFF6E1E42); // --accent-dark
  static const Color mint = Color(0xFFBFE8D4); // --mint
  static const Color textMuted = Color(0xFF8C5468); // --text-muted
  static const Color line = Color(0xFFF2B8D2); // --line
  static const Color danger = Color(0xFFB42318); // .form-error

  static const double radius = 4.0; // --radius: 4px

  // === Tipografi ===
  static TextStyle displayStyle({
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.w700,
    Color color = ink,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: 'Space Grotesk',
      fontFamilyFallback: const ['sans-serif'],
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle monoStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = ink,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: 'Lucida Console',
      fontFamilyFallback: const ['Courier New', 'monospace'],
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: paper,
      fontFamily: 'Lucida Console',
      fontFamilyFallback: const ['Courier New', 'monospace'],
      colorScheme: const ColorScheme.light(
        primary: accentDark,
        onPrimary: paper,
        secondary: accent,
        onSecondary: ink,
        surface: card,
        onSurface: ink,
        error: danger,
        onError: paper,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: accentDark,
        foregroundColor: paper,
        elevation: 0,
        titleTextStyle: displayStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: paper,
        ),
        iconTheme: const IconThemeData(color: paper),
        shape: const Border(
          bottom: BorderSide(color: ink, width: 2.0),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: card,
        labelStyle: monoStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w700,
          color: ink,
        ),
        hintStyle: monoStyle(
          fontSize: 13,
          color: textMuted,
        ),
        errorStyle: monoStyle(
          fontSize: 12,
          color: danger,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 14.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: accentDark, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: accent, width: 2.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: danger, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: danger, width: 2.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentDark,
          foregroundColor: paper,
          elevation: 0,
          textStyle: monoStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: paper,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: const BorderSide(color: accentDark, width: 2.0),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentDark,
          textStyle: monoStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: accentDark,
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: paper,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: const BorderSide(color: accentDark, width: 2.0),
        ),
        titleTextStyle: displayStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: ink,
        ),
        contentTextStyle: monoStyle(
          fontSize: 13.5,
          color: ink,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: accentDark,
        contentTextStyle: monoStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: paper,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: const BorderSide(color: ink, width: 1.5),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}