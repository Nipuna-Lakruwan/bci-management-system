import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Premium Color Palette
  static const Color primaryBlue = Color(0xFF1E3A8A); // Deep Blue
  static const Color primaryLight = Color(0xFF3B82F6); // Lighter Blue
  static const Color accentAmber = Color(0xFFF59E0B); // Amber
  static const Color surfaceColor = Colors.white;
  static const Color backgroundColor = Color(0xFFF8FAFC); // Very Light Slate
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900
  static const Color textSecondary = Color(0xFF64748B); // Slate 500

  // Reusable Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        secondary: accentAmber,
        surface: surfaceColor,
        background: backgroundColor,
      ),
      // Premium Typography Mix (Outfit for headers, Inter for body)
      textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
      ).copyWith(
        displayLarge: GoogleFonts.outfit(color: textPrimary, fontWeight: FontWeight.bold),
        displayMedium: GoogleFonts.outfit(color: textPrimary, fontWeight: FontWeight.bold),
        displaySmall: GoogleFonts.outfit(color: textPrimary, fontWeight: FontWeight.bold),
        headlineLarge: GoogleFonts.outfit(color: textPrimary, fontWeight: FontWeight.bold),
        headlineMedium: GoogleFonts.outfit(color: textPrimary, fontWeight: FontWeight.bold),
        headlineSmall: GoogleFonts.outfit(color: textPrimary, fontWeight: FontWeight.w600),
        titleLarge: GoogleFonts.outfit(color: textPrimary, fontWeight: FontWeight.w600),
        titleMedium: GoogleFonts.outfit(color: textPrimary, fontWeight: FontWeight.w600),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.outfit(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: primaryLight.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Smoother edges
          ),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryLight, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        labelStyle: GoogleFonts.inter(color: textSecondary),
        prefixIconColor: textSecondary,
      ),
      cardTheme: CardThemeData(
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: surfaceColor,
        margin: const EdgeInsets.all(8),
      ),
    );
  }
}
