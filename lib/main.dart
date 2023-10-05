import 'package:event_checker/res/themes.dart';
import 'package:event_checker/screens/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EventPlanner());
}

class EventPlanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      home: SplashScreen(),
    );
  }
}
