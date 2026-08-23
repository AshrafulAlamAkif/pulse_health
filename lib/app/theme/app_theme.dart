import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';


class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // পুরো app-এর background color।
      scaffoldBackgroundColor: AppColors.background,

      // Primary color।
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
      ),

      // App-এর default font পরে এখানে configure করব।
      fontFamily: 'Inter',

      // AppBar-এর default appearance।
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
    );
  }
}