import 'package:event_checker/res/colors.dart';
import 'package:flutter/material.dart';

Widget buildCategoryPreview(BuildContext context, IconData icon) {
  return CircleAvatar(
    child: Icon(icon, color: Colors.white),
    radius: 22.5,
    backgroundColor:
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? AppColors.primaryLight
            : AppColors.primaryDark,
  );
}
