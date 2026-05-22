import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

abstract final class AppTheme {
  // Surfaces
  static const background = Color(0xFF0F131F);
  static const surfaceLowest = Color(0xFF0A0E1A);
  static const surfaceLow = Color(0xFF171B28);
  static const surface = Color(0xFF1B1F2C);
  static const surfaceHigh = Color(0xFF262A37);
  static const surfaceHighest = Color(0xFF313442);

  // Text
  static const onSurface = Color(0xFFDFE2F3);
  static const onSurfaceVariant = Color(0xFFB9CACB);
  static const outline = Color(0xFF849495);
  static const outlineVariant = Color(0xFF3A494B);

  // Brand
  static const cyan = Color(0xFF00DBE7);
  static const cyanBright = Color(0xFF00F2FF);
  static const mint = Color(0xFF36FFC4);
  static const errorRed = Color(0xFFFFAB91);
  static const dueBadge = Color(0xFFFF6B6B);

  static const double screenMargin = 20;
  static const double cardPadding = 20;
  static const double radiusCard = 16;
  static const double radiusModal = 24;
  static const double radiusButton = 12;
  static const double radiusPill = 999;

  static BoxDecoration glassCard({bool isActive = false, bool isDue = false}) =>
      BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(radiusCard),
        border: Border.all(
          color: isDue
              ? AppTheme.dueBadge.withValues(alpha: 0.6)
              : isActive
                  ? AppTheme.cyan.withValues(alpha: 0.6)
                  : Colors.white.withValues(alpha: 0.07),
          width: isActive || isDue ? 1.5 : 1.0,
        ),
      );

  static TextStyle headlineLg = GoogleFonts.hankenGrotesk(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: onSurface,
    letterSpacing: -0.5,
  );

  static TextStyle headlineMd = GoogleFonts.hankenGrotesk(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: onSurface,
  );

  static TextStyle titleMd = GoogleFonts.hankenGrotesk(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: onSurface,
  );

  static TextStyle bodyMd = GoogleFonts.hankenGrotesk(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: onSurface,
  );

  static TextStyle labelCyan = GoogleFonts.hankenGrotesk(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: cyan,
    letterSpacing: 1.4,
  );

  static TextStyle bodySm = GoogleFonts.hankenGrotesk(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: onSurfaceVariant,
  );

  static TextStyle amountLg = GoogleFonts.hankenGrotesk(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: onSurface,
  );

  static TextStyle amountHero = GoogleFonts.hankenGrotesk(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: onSurface,
  );

  static TextStyle amountQuickLog = GoogleFonts.hankenGrotesk(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: onSurface,
  );

  static final NumberFormat _currencyFormat = NumberFormat('#,##0.00', 'en_US');

  static String formatCurrency(double amount, {bool showSign = false}) {
    final formatted = _currencyFormat.format(amount.abs());
    if (showSign && amount > 0) return '+EGP $formatted';
    if (amount < 0) return '-EGP $formatted';
    return 'EGP $formatted';
  }

  static BoxDecoration innerCard() => BoxDecoration(
        color: surfaceLow,
        borderRadius: BorderRadius.circular(radiusCard),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      );

  static BoxDecoration squircle({Color? color}) => BoxDecoration(
        color: color ?? surfaceHigh,
        borderRadius: BorderRadius.circular(radiusButton),
      );

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        surface: surface,
        onSurface: onSurface,
        primary: cyan,
        secondary: mint,
        outline: outline,
        error: errorRed,
      ),
      textTheme: GoogleFonts.hankenGroteskTextTheme(
        ThemeData.dark().textTheme,
      ).apply(bodyColor: onSurface, displayColor: onSurface),
    );
  }
}
