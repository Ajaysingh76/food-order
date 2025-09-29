import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VibrantBites {
  // Colors
  static const Color boldOrangeRed = Color(0xFFFF4500); // Primary
  static const Color warmYellow = Color(0xFFFFD700); // Secondary
  static const Color darkGrey = Color(0xFF212121); // Dark background
  static const Color jetBlack = Color(0xFF000000); // Darker background
  static const Color creamyOffWhite = Color(0xFFFDF8F3); // Light background
  static const Color charcoal = Color(0xFF212121); // Text primary
  static const Color mediumGrey = Color(0xFF757575); // Text secondary light bg
  static const Color lightGrey = Color(0xFFB0B0B0); // Text secondary dark bg
  static const Color white = Color(0xFFFFFFFF);

  // Spacing & Styling - Consistent 12-16px border radius
  static const double screenPadding = 20.0;
  static const double cardPadding = 16.0;
  static const double cardBorderRadius = 16.0;
  static const double buttonBorderRadius = 14.0;
  static const double searchBarBorderRadius = 14.0;
  static const double overlayButtonRadius = 12.0;
  static const double cardElevation = 4.0;
  static const double buttonElevation = 2.0;
  static const double overlayElevation = 8.0;
  static const double elementSpacing = 16.0;
  static const double smallSpacing = 12.0;
  static const double sectionSpacing = 24.0;

  // Typography Hierarchy - Clear distinction between heading levels
  // H1 - Main titles (28px)
  static TextStyle get headingExtraBold => GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: charcoal,
      );

  // H2 - Section headers (22px)
  static TextStyle get headingBold => GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: charcoal,
      );

  // H3 - Card titles (18px)
  static TextStyle get headingSemiBold => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: charcoal,
      );

  // H4 - Small headings (16px)
  static TextStyle get headingMedium => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: charcoal,
      );

  // Light headings for dark backgrounds
  static TextStyle get headingLight => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: white,
      );

  // Body text (16px)
  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: charcoal,
      );

  // Body text (14px)
  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: charcoal,
      );

  // Small text (12px)
  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: mediumGrey,
      );

  // Light body text for dark backgrounds
  static TextStyle get bodyLight => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: white,
      );

  // Secondary text
  static TextStyle get bodySecondaryDark => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: mediumGrey,
      );

  static TextStyle get bodySecondaryLight => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: lightGrey,
      );

  // Price text - prominent
  static TextStyle get priceText => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: boldOrangeRed,
      );

  // Button text
  static TextStyle get buttonText => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: white,
      );

  // Legacy styles for compatibility
  static TextStyle get bodyDark => bodyLarge;

  static ThemeData theme() {
    final base = ThemeData(useMaterial3: true, colorSchemeSeed: boldOrangeRed);
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: boldOrangeRed,
        secondary: warmYellow,
        surface: creamyOffWhite,
        onPrimary: white,
        onSecondary: charcoal,
        onSurface: charcoal,
      ),
      scaffoldBackgroundColor: creamyOffWhite,
      textTheme: TextTheme(
        displayLarge: headingBold,
        displayMedium: headingBold,
        displaySmall: headingBold,
        headlineLarge: headingBold.copyWith(fontSize: 28),
        headlineMedium: headingBold.copyWith(fontSize: 24),
        headlineSmall: headingBold.copyWith(fontSize: 20),
        titleLarge: headingBold.copyWith(fontSize: 22),
        titleMedium: headingBold.copyWith(fontSize: 18),
        titleSmall: headingBold.copyWith(fontSize: 16),
        bodyLarge: bodyDark.copyWith(fontSize: 16),
        bodyMedium: bodyDark.copyWith(fontSize: 14),
        bodySmall: bodySecondaryDark.copyWith(fontSize: 12),
        labelLarge: GoogleFonts.poppins(fontWeight: FontWeight.w700, color: white, fontSize: 16),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkGrey,
        foregroundColor: white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: headingLight.copyWith(fontSize: 18),
        iconTheme: const IconThemeData(color: white),
      ),
      cardTheme: CardThemeData(
        elevation: cardElevation,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shadowColor: Colors.black.withAlpha((255 * 0.1).round()),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(cardBorderRadius)),
        color: white,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          foregroundColor: white,
          backgroundColor: boldOrangeRed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonBorderRadius)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: boldOrangeRed,
          side: const BorderSide(color: boldOrangeRed, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonBorderRadius)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: white,
        selectedItemColor: boldOrangeRed,
        unselectedItemColor: mediumGrey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 12),
        unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 12),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(buttonBorderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(buttonBorderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(buttonBorderRadius),
          borderSide: const BorderSide(color: boldOrangeRed, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        hintStyle: bodySecondaryDark.copyWith(fontSize: 14),
      ),
    );
  }
}
