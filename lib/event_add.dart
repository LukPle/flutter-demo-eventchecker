import 'package:flutter/material.dart';
import 'event.dart';
import 'event_list.dart';

class AddEvent extends StatefulWidget {

  @override
  AddEventState createState() => AddEventState();
}

class AddEventState extends State<AddEvent> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  Widget buildEmptySpace(double height) {

    return SizedBox(height: height);
  }

  Widget buildTextField(String labelText, String hintText, TextEditingController controller) {

    return TextField(
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText: hintText
      ),
      maxLines: 1,
      controller: controller,
    );
  }

  Widget buildButton(String buttonText) {

    return ElevatedButton(
        child: Text(buttonText,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        onPressed: () {
          Event event = Event(titleController.text.trim(), descriptionController.text.trim());
          Navigator.pop(context, event);
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: const Text("Add Event")
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildEmptySpace(16),
            buildTextField("Event Title", "Concert", titleController),
            buildEmptySpace(24),
            buildTextField("Event Description", "My favourite band", descriptionController),
            buildEmptySpace(64),
            buildButton("Create Event")
          ])
      )
    );
  }
}