import 'package:event_checker/res/colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryLight,
      secondaryHeaderColor: AppColors.accentLight,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundLight);

  static ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.primaryDark,
      secondaryHeaderColor: AppColors.accentDark,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundDark);
}
