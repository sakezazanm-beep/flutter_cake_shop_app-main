import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const red = Color(0xFFF20D18);
  static const redDark = Color(0xFFD90D17);
  static const pink = Color(0xFFFFF3F5);
  static const pinkLine = Color(0xFFF2DDE1);
  static const text = Color(0xFF332B2C);
  static const muted = Color(0xFF82777A);
  static const cream = Color(0xFFFFFBF8);
}

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: AppColors.pink,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.red,
      primary: AppColors.red,
      surface: Colors.white,
    ),
    textTheme: GoogleFonts.kanitTextTheme().apply(
      bodyColor: AppColors.text,
      displayColor: AppColors.text,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.red,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: GoogleFonts.kanit(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
  );
}
