import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UrbanHarvest {
  // Colors
  static const Color forestGreen = Color(0xFF388E3C); // Primary
  static const Color goldenrod = Color(0xFFFFC107); // Accent
  static const Color creamyOffWhite = Color(0xFFFDF8F3); // Background
  static const Color charcoal = Color(0xFF212121); // Text primary
  static const Color mediumGrey = Color(0xFF757575); // Text secondary
  static const Color deepOrange = Color(0xFFFF5722); // Error

  // Spacing
  static const double screenPadding = 16.0;
  static const double cardElevation = 3.0;

  // Text styles
  static TextStyle get heading => GoogleFonts.montserrat(
        fontWeight: FontWeight.w700,
        color: charcoal,
      );

  static TextStyle get body => GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        color: charcoal,
      );

  static ThemeData theme() {
    final base = ThemeData(useMaterial3: true, colorSchemeSeed: forestGreen);
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: forestGreen,
        secondary: goldenrod,
        error: deepOrange,
        surface: creamyOffWhite,
      ),
      scaffoldBackgroundColor: creamyOffWhite,
      textTheme: TextTheme(
        displayLarge: heading,
        displayMedium: heading,
        displaySmall: heading,
        headlineLarge: heading,
        headlineMedium: heading,
        headlineSmall: heading,
        titleLarge: heading.copyWith(fontWeight: FontWeight.w700),
        titleMedium: heading.copyWith(fontWeight: FontWeight.w700),
        titleSmall: heading.copyWith(fontWeight: FontWeight.w600),
        bodyLarge: body,
        bodyMedium: body.copyWith(color: mediumGrey),
        bodySmall: body.copyWith(color: mediumGrey),
        labelLarge: GoogleFonts.montserrat(fontWeight: FontWeight.w700, color: Colors.white),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: creamyOffWhite,
        foregroundColor: charcoal,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: heading.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      cardTheme: const CardThemeData(
        elevation: cardElevation,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: forestGreen,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: forestGreen,
          side: const BorderSide(color: forestGreen),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: const Color(0xFFE0E0E0),
        selectedColor: goldenrod,
        labelStyle: body,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
