import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color teal = Color(0xFF00C9B1);
  static const Color tealDark = Color(0xFF00A896);
  static const Color tealLight = Color(0xFFE0F7F5);
  static const Color orange = Color(0xFFFF6B35);
  static const Color dark = Color(0xFF1A1A2E);
  static const Color grey = Color(0xFF8A8A9A);
  static const Color lightBg = Color(0xFFF8FAFB);
  static const Color white = Colors.white;

  static ThemeData get theme {
    return ThemeData(
      primaryColor: teal,
      scaffoldBackgroundColor: lightBg,
      colorScheme: ColorScheme.fromSeed(seedColor: teal, primary: teal),
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: dark,
      ),
    );
  }
}
