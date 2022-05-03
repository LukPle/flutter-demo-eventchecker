import 'package:flutter/material.dart';
import 'event_list.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        secondaryHeaderColor: Colors.blueAccent,
        scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 245)
      ),
      home: EventList(),
    );
  }
}