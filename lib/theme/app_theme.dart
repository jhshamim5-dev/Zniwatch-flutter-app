name=lib/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'constants.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.dark900,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.dark600,
      surface: AppColors.dark800,
      background: AppColors.dark900,
      error: Colors.red.shade500,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.dark600,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        fontFamily: 'Plus Jakarta Sans',
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Plus Jakarta Sans',
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Plus Jakarta Sans',
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Plus Jakarta Sans',
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontFamily: 'Plus Jakarta Sans',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontFamily: 'Plus Jakarta Sans',
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontFamily: 'Plus Jakarta Sans',
      ),
    ),
  );
}
