name=lib/theme/constants.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1DB954);
  static const Color darkGreen = Color(0xFF158A3d);
  static const Color glowGreen = Color(0xFF1ed760);
  
  static const Color dark900 = Color(0xFF000000);
  static const Color dark800 = Color(0xFF0a0a0a);
  static const Color dark700 = Color(0xFF141414);
  static const Color dark600 = Color(0xFF1a1a1a);
  static const Color dark500 = Color(0xFF242424);
  
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3B3B3);
  static const Color textMuted = Color(0xFF666666);
}

class AppConstants {
  static const String apiBaseUrl = 'https://kaido-api-v1-opal.vercel.app';
  static const String aniListGraphQL = 'https://graphql.anilist.co';
  static const int requestTimeout = 15000; // 15 seconds
  static const int debounceDelay = 300;
}
