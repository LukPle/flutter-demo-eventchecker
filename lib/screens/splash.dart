import 'dart:async';
import 'package:event_checker/res/colors.dart';
import 'package:event_checker/screens/event_list.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<Color> colorsLight = [
    AppColors.primaryLight,
    AppColors.secondaryLight,
    AppColors.tertiaryLight
  ];
  List<Color> colorsDark = [
    AppColors.primaryDark,
    AppColors.secondaryDark,
    AppColors.tertiaryDark
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => EventList()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.5, 1.0],
            colors:
                MediaQuery.of(context).platformBrightness == Brightness.light
                    ? colorsLight
                    : colorsDark,
          ),
        ),
        child: Center(
          child: Lottie.asset('assets/lottie.json', repeat: false),
        ),
      ),
    );
  }
}
