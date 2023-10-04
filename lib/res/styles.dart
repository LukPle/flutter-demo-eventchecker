import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle headingStyle =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w500);

  static const TextStyle heavyTextStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  static const TextStyle textStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400);

  TextStyle coloredTextStyle(Brightness displayBrightness) => TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color:
          displayBrightness == Brightness.light ? Colors.black : Colors.white);

  TextStyle fadedTextStyle(Brightness displayBrightness) => TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: displayBrightness == Brightness.light
          ? Colors.black54
          : Colors.white70);

  static const TextStyle buttonStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w500);

  TextStyle searchTextStyle(bool isHint) {
    return TextStyle(
        fontSize: 20,
        fontWeight: isHint ? FontWeight.w400 : FontWeight.w500,
        color: isHint ? Colors.white70 : Colors.white);
  }
}

class AppBorders {
  static BorderRadius borderRadius = BorderRadius.circular(15);
}
