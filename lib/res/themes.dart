import 'package:event_checker/res/colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.primaryLight,
      onPrimary: Colors.white,
      secondary: AppColors.secondaryLight,
      onSecondary: Colors.white,
      background: AppColors.scaffoldBackgroundLight,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.primaryDark,
      onPrimary: Colors.white,
      secondary: AppColors.secondaryDark,
      onSecondary: Colors.white,
      background: AppColors.scaffoldBackgroundDark,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryDark,
    ),
  );
}
