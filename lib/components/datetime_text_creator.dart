String convertDateTimeToText(DateTime dateTime, {excludeTime = false}) {
  String dateTimeText = dateTime.day.toString().padLeft(2, "0") +
      "." +
      dateTime.month.toString().padLeft(2, "0") +
      "." +
      dateTime.year.toString();

  return excludeTime
      ? dateTimeText
      : dateTimeText +
          " - " +
          dateTime.hour.toString().padLeft(2, "0") +
          ":" +
          dateTime.minute.toString().padLeft(2, "0");
}

String getWeekdayName(int weekday) {
  switch (weekday) {
    case 1:
      return "Monday";
    case 2:
      return "Tuesday";
    case 3:
      return "Wednesday";
    case 4:
      return "Thursday";
    case 5:
      return "Friday";
    case 6:
      return "Saturday";
    case 7:
      return "Sunday";
    default:
      throw const FormatException("Given weekday not in range.");
  }
}
