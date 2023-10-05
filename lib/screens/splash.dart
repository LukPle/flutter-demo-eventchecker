import 'dart:async';
import 'package:event_checker/screens/event_list.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => EventList())));

    return Scaffold(
      body: Center(
        child: Text("Hallo"),
      ),
    );
  }
}
