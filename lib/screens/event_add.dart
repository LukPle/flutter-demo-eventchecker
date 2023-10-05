import 'package:event_checker/components/category_preview.dart';
import 'package:event_checker/data/event_types.dart';
import 'package:event_checker/res/strings.dart';
import 'package:event_checker/res/styles.dart';
import 'package:flutter/material.dart';
import '../data/event.dart';

class AddEvent extends StatefulWidget {
  @override
  AddEventState createState() => AddEventState();
}

class AddEventState extends State<AddEvent> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late EventTypes eventType = EventTypes.concert;
  late DateTime dateTime;
  String dateTimeText = "Date and Time";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.addEventScreenLabel)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 5),
                buildGeneralInformationArea(),
                const SizedBox(height: 25),
                buildTimeLocationArea(),
                const SizedBox(height: 25),
                buildCategoryTypeArea(),
                const SizedBox(height: 50),
                buildElevatedButton(AppStrings.createButtonLabel),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGeneralInformationArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppStrings.generalInformationHeading,
            style: AppTextStyles.headingStyle),
        const SizedBox(height: 10),
        buildTextField(AppStrings.eventTitleHint, titleController),
        const SizedBox(height: 10),
        buildTextField(AppStrings.eventDescriptionHint, descriptionController),
      ],
    );
  }

  Widget buildTimeLocationArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppStrings.timeLocationHeading,
            style: AppTextStyles.headingStyle),
        const SizedBox(height: 10),
        buildOutlinedButton(dateTimeText),
      ],
    );
  }

  Widget buildCategoryTypeArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(AppStrings.categoryTypeHeading,
            style: AppTextStyles.headingStyle),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildCategoryPreview(context, getEventTypeIcon(eventType)),
            const SizedBox(width: 15),
            Expanded(child: buildDropDown()),
          ],
        ),
      ],
    );
  }

  Widget buildTextField(String hintText, TextEditingController controller) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: AppBorders.borderRadius),
        hintText: hintText,
        hintStyle: AppTextStyles()
            .fadedTextStyle(MediaQuery.of(context).platformBrightness),
      ),
      style: AppTextStyles.heavyTextStyle,
      maxLines: 1,
      controller: controller,
    );
  }

  Widget buildDropDown() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: AppBorders.borderRadius,
          border: Border.all(color: Colors.grey)),
      child: Center(
        child: DropdownButton(
          value: getEventTypeText(eventType),
          items: getAllEventTypeTexts().map((value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
          style: AppTextStyles()
              .coloredTextStyle(MediaQuery.of(context).platformBrightness),
          onChanged: (dynamic newValue) {
            setState(() {
              eventType = getEventTypeValue(newValue.toString());
            });
          },
        ),
      ),
    );
  }

  Widget buildElevatedButton(String buttonText) {
    return ElevatedButton(
        child: Text(buttonText, style: AppTextStyles.buttonStyle),
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            shape:
                RoundedRectangleBorder(borderRadius: AppBorders.borderRadius)),
        onPressed: () {
          Event event = Event(
              titleController.text.trim(),
              descriptionController.text.trim(),
              eventType,
              dateTime,
              dateTimeText);
          Navigator.pop(context, event);
        });
  }

  Widget buildOutlinedButton(String buttonText) {
    return OutlinedButton(
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(buttonText,
              style: buttonText == "Date and Time"
                  ? AppTextStyles()
                      .fadedTextStyle(MediaQuery.of(context).platformBrightness)
                  : AppTextStyles().coloredTextStyle(
                      MediaQuery.of(context).platformBrightness)),
        ),
        style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            side: const BorderSide(width: 1.25, color: Colors.grey),
            shape:
                RoundedRectangleBorder(borderRadius: AppBorders.borderRadius)),
        onPressed: () {
          pickDateTime(context);
        });
  }

  Future pickDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) {
      return;
    }

    final time = await pickTime(context);
    if (time == null) {
      return;
    }

    setState(() {
      dateTime =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);

      dateTimeText = dateTime.day.toString().padLeft(2, "0") +
          "." +
          dateTime.month.toString().padLeft(2, "0") +
          "." +
          dateTime.year.toString() +
          " - " +
          dateTime.hour.toString().padLeft(2, "0") +
          ":" +
          dateTime.minute.toString().padLeft(2, "0");
    });
  }

  Future pickDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 25));

    if (selectedDate == null) {
      return null;
    } else {
      return selectedDate;
    }
  }

  Future pickTime(BuildContext context) async {
    final selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (selectedTime == null) {
      return null;
    } else {
      return selectedTime;
    }
  }
}
