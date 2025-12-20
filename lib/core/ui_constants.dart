import 'package:flutter/cupertino.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF007AFF);
  static const Color background = Color(0xFFF2F2F7); // iOS grouped background
  static const Color surface = CupertinoColors.white;
  static const Color textMain = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color divider = Color(0xFFC6C6C8);
  static const Color shadow = Color(0x1F000000);
}

class AppStyles {
  AppStyles._();

  static BoxShadow get cardShadow => const BoxShadow(
        color: AppColors.shadow,
        offset: Offset(0, 4),
        blurRadius: 12,
        spreadRadius: 0,
      );

  static BoxDecoration get cardDecoration => BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [cardShadow],
      );

  static TextStyle get headerTitle => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        color: AppColors.textMain,
      );
  
  static TextStyle get cardTitle => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textMain,
  );

  static TextStyle get cardSubtitle => const TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
}
