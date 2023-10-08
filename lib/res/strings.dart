class AppStrings {
  static const String appName = "Event Planner";

  // User Name Dialog
  static const String userNameDialogHeader = "Before starting ...";
  static const String userNameDialogBody =
      "... please choose a username to display inside the app. Your data is saved locally on the device and not shared anywhere else.";
  static const String saveUsernameButtonLabel = "Save Username";
  static const String usernameKey = "username";

  // EventList
  static const String previewLabel = "No Upcoming Events";
  static const String searchLabel = "Search";

  String headerDateTime(String weekday, String dateTimeText) {
    return "$weekday, the $dateTimeText";
  }

  String headerGreeting(DateTime dateTime, String name) {
    String timeOfDayGreeting = "";

    int currentHour = dateTime.hour;
    int morningStart = 5;
    int afternoonStart = 11;
    int eveningStart = 17;
    int nightStart = 0;

    if (currentHour >= morningStart && currentHour < afternoonStart) {
      timeOfDayGreeting = "Good Morning";
    } else if (currentHour >= afternoonStart && currentHour < eveningStart) {
      timeOfDayGreeting = "Good Afternoon";
    } else if (currentHour >= eveningStart && currentHour > nightStart) {
      timeOfDayGreeting = "Good Evening";
    } else if (currentHour >= nightStart && currentHour < morningStart) {
      timeOfDayGreeting = "Good Night";
    } else {
      timeOfDayGreeting = "Hello";
    }

    return "$timeOfDayGreeting $name";
  }

  static const String weeklyEventsHeading = "This Week";
  static const String laterEventsHeading = "Later Events";
  static const String noEventsAvailableLabel =
      "No Events Planned For This Week";
  static const String addButtonLabel = "Add New Event";

  // AddEvent
  static const String addEventScreenLabel = "Add Event";
  static const String generalInformationHeading = "General Information";
  static const String eventTitleHint = "Event Title";
  static const String eventDescriptionHint = "Event Description";
  static const String timeLocationHeading = "Time and Location";
  static const String categoryTypeHeading = "Category and Type";
  static const String createButtonLabel = "Create Event";
}
