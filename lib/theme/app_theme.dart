import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Fintrack design system — dark mode only.
abstract final class AppColors {
  static const background = Color(0xFF0F131F);
  static const surface = Color(0xFF0F131F);
  static const surfaceContainerLowest = Color(0xFF0A0E1A);
  static const surfaceContainerLow = Color(0xFF171B28);
  static const surfaceContainer = Color(0xFF1B1F2C);
  static const surfaceContainerHigh = Color(0xFF262A37);
  static const surfaceContainerHighest = Color(0xFF313442);
  static const onSurface = Color(0xFFDFE2F3);
  static const onSurfaceVariant = Color(0xFFB9CACB);
  static const outline = Color(0xFF849495);
  static const outlineVariant = Color(0xFF3A494B);
  static const primary = Color(0xFF00DBE7);
  static const primaryContainer = Color(0xFF00F2FF);
  static const secondary = Color(0xFF36FFC4);
  static const errorDue = Color(0xFFFFAB91);
  static const onPrimaryDark = Color(0xFF0F131F);
}

abstract final class AppSpacing {
  static const double unit = 8;
  static const double screenMargin = 20;
  static const double cardPadding = 20;
}

abstract final class AppRadius {
  static const double card = 16;
  static const double modal = 24;
  static const double button = 12;
  static const double pill = 999;
}

abstract final class AppTheme {
  static TextStyle _base({
    required double size,
    required FontWeight weight,
    Color color = AppColors.onSurface,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.hankenGrotesk(
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle get headlineLg =>
      _base(size: 28, weight: FontWeight.w700, color: AppColors.onSurface);

  static TextStyle get headlineMd =>
      _base(size: 22, weight: FontWeight.w700, color: AppColors.onSurface);

  static TextStyle get titleLg =>
      _base(size: 18, weight: FontWeight.w600, color: AppColors.onSurface);

  static TextStyle get titleMd =>
      _base(size: 16, weight: FontWeight.w600, color: AppColors.onSurface);

  static TextStyle get bodyLg =>
      _base(size: 15, weight: FontWeight.w500, color: AppColors.onSurface);

  static TextStyle get bodyMd =>
      _base(size: 14, weight: FontWeight.w400, color: AppColors.onSurface);

  static TextStyle get bodySm => _base(
        size: 13,
        weight: FontWeight.w400,
        color: AppColors.onSurfaceVariant,
      );

  static TextStyle get labelLg => _base(
        size: 12,
        weight: FontWeight.w600,
        color: AppColors.primary,
        letterSpacing: 1.2,
      );

  static TextStyle get labelMd => _base(
        size: 11,
        weight: FontWeight.w600,
        color: AppColors.onSurfaceVariant,
        letterSpacing: 0.8,
      );

  static TextStyle get amountHero =>
      _base(size: 36, weight: FontWeight.w700, color: AppColors.onSurface);

  static TextStyle get amountLg =>
      _base(size: 28, weight: FontWeight.w700, color: AppColors.onSurface);

  static TextStyle get amountMd =>
      _base(size: 20, weight: FontWeight.w700, color: AppColors.onSurface);

  static TextStyle get amountQuickLog =>
      _base(size: 40, weight: FontWeight.w700, color: AppColors.onSurface);

  static BoxDecoration glassCard({bool active = false}) {
    return BoxDecoration(
      color: AppColors.surfaceContainer,
      borderRadius: BorderRadius.circular(AppRadius.card),
      border: Border.all(
        color: active
            ? AppColors.primary
            : const Color(0xFFFFFFFF).withValues(alpha: 0.07),
        width: active ? 1.5 : 1,
      ),
    );
  }

  static BoxDecoration innerCard() {
    return BoxDecoration(
      color: AppColors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(AppRadius.card),
      border: Border.all(
        color: const Color(0xFFFFFFFF).withValues(alpha: 0.05),
      ),
    );
  }

  static BoxDecoration squircle({Color? color}) {
    return BoxDecoration(
      color: color ?? AppColors.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(AppRadius.button),
    );
  }

  static String formatAmount(double amount, {bool showSign = false}) {
    final isNegative = amount < 0;
    final abs = amount.abs();
    final parts = abs.toStringAsFixed(2).split('.');
    final intStr = parts[0];
    final dec = parts[1];
    final buf = StringBuffer();
    for (var i = 0; i < intStr.length; i++) {
      if (i > 0 && (intStr.length - i) % 3 == 0) buf.write(',');
      buf.write(intStr[i]);
    }
    var result = 'EGP $buf.$dec';
    if (showSign && amount > 0) {
      result = '+$result';
    } else if (isNegative) {
      result = '-$result';
    }
    return result;
  }

  static ThemeData darkTheme() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        outline: AppColors.outline,
        error: AppColors.errorDue,
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.hankenGroteskTextTheme(base.textTheme).apply(
        bodyColor: AppColors.onSurface,
        displayColor: AppColors.onSurface,
      ),
    );
  }
}
