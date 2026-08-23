import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // App-এর main background।
  //
  // Pure white (#FFFFFF) ব্যবহার না করে
  // একটু soft background রাখছি যাতে UI বেশি premium লাগে।
  static const Color background = Color(0xFFF7F8F6);

  // Main dark color।
  // Text এবং গুরুত্বপূর্ণ UI element-এ ব্যবহার করব।
  static const Color dark = Color(0xFF17201C);

  // আমাদের primary healthcare accent।
  static const Color primary = Color(0xFF3E7C68);

  // Light version of primary।
  static const Color primaryLight = Color(0xFFDCEDE6);

  // Emergency feature-এর জন্য।
  static const Color emergency = Color(0xFFE85D5D);

  // Secondary text।
  static const Color textSecondary = Color(0xFF7A827E);

  // Card/background surface।
  static const Color surface = Color(0xFFFFFFFF);
}