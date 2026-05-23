import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static const Color _deep = Color(0xFF0B3D5C);
  static const Color _mid = Color(0xFF1A7FB5);
  static const Color _light = Color(0xFF7DD3FC);
  static const Color _foam = Color(0xFFE8F6FC);
  static const Color _surface = Color(0xFFF8FBFD);

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _mid,
        primary: _deep,
        secondary: _mid,
        surface: _surface,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: _surface,
    );

    final textTheme = GoogleFonts.dmSansTextTheme(base.textTheme);

    return base.copyWith(
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: _surface,
        foregroundColor: _deep,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: _deep,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: _deep,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      extensions: [
        WaterColors(
          deep: _deep,
          mid: _mid,
          light: _light,
          foam: _foam,
        ),
      ],
    );
  }
}

class WaterColors extends ThemeExtension<WaterColors> {
  const WaterColors({
    required this.deep,
    required this.mid,
    required this.light,
    required this.foam,
  });

  final Color deep;
  final Color mid;
  final Color light;
  final Color foam;

  @override
  WaterColors copyWith({
    Color? deep,
    Color? mid,
    Color? light,
    Color? foam,
  }) {
    return WaterColors(
      deep: deep ?? this.deep,
      mid: mid ?? this.mid,
      light: light ?? this.light,
      foam: foam ?? this.foam,
    );
  }

  @override
  WaterColors lerp(ThemeExtension<WaterColors>? other, double t) {
    if (other is! WaterColors) return this;
    return WaterColors(
      deep: Color.lerp(deep, other.deep, t)!,
      mid: Color.lerp(mid, other.mid, t)!,
      light: Color.lerp(light, other.light, t)!,
      foam: Color.lerp(foam, other.foam, t)!,
    );
  }
}

extension WaterColorsX on BuildContext {
  WaterColors get waterColors => Theme.of(this).extension<WaterColors>()!;
}
