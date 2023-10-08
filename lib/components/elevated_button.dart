import 'package:event_checker/res/styles.dart';
import 'package:flutter/material.dart';

Widget buildElevatedButton(String buttonText, VoidCallback action, {bool isEnabled = true}) {
  return ElevatedButton(
    child: Text(buttonText, style: AppTextStyles.buttonStyle),
    style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: AppBorders.borderRadius)),
    onPressed: isEnabled ? action : null,
  );
}
