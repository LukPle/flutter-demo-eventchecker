import 'package:flutter/material.dart';
import 'event.dart';
import 'event_list.dart';

class AddEvent extends StatefulWidget {

  @override
  AddEventState createState() => AddEventState();
}

class AddEventState extends State<AddEvent> {

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: const Text("Add Event")
      ),
      body: const Text("New Event")
    );
  }
}