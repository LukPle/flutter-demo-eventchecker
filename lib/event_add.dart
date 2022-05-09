import 'package:flutter/material.dart';
import 'event.dart';

class AddEvent extends StatefulWidget {

  @override
  AddEventState createState() => AddEventState();
}

class AddEventState extends State<AddEvent> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late DateTime dateTime;
  String dateTimeText = "Date and Time";

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

  Widget buildElevatedButton(String buttonText) {

    return ElevatedButton(
        child: Text(buttonText,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        onPressed: () {
          Event event = Event(
              titleController.text.trim(),
              descriptionController.text.trim(),
              dateTime,
              dateTimeText);
          Navigator.pop(context, event);
        }
    );
  }

  Widget buildOutlinedButton(String buttonText) {

    return OutlinedButton(
        child: Text(buttonText,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
        style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(55),
            side: const BorderSide(width: 1.25, color: Colors.grey),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        onPressed: () {
          pickDateTime(context);
        }
    );
  }

  Future pickDateTime(BuildContext context) async {

    final date = await pickDate(context);
    if(date == null) {return;}

    final time = await pickTime(context);
    if(time == null) {return;}

    setState(() {

      dateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute
      );

      dateTimeText = dateTime.day.toString().padLeft(2, "0") + "." +
          dateTime.month.toString().padLeft(2, "0") + "." +
          dateTime.year.toString() + " - " +
          dateTime.hour.toString().padLeft(2, "0") + ":" +
          dateTime.minute.toString().padLeft(2, "0");
    });
  }

  Future pickDate(BuildContext context) async {

    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 25)
    );

    if(selectedDate == null) {

      return null;
    }
    else {

      return selectedDate;
    }
  }

  Future pickTime(BuildContext context) async {

    final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );

    if(selectedTime == null) {

      return null;
    }
    else {

      return selectedTime;
    }
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
            buildEmptySpace(24),
            buildOutlinedButton(dateTimeText),
            buildEmptySpace(64),
            buildElevatedButton("Create Event")
          ])
      )
    );
  }
}