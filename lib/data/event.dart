import 'package:event_checker/data/event_types.dart';

class Event {
  String title;
  String description;
  EventTypes eventType;
  DateTime dateTime;
  String dateTimeText;
  // type, outdoor, indoor
  // location

  Event(this.title, this.description, this.eventType, this.dateTime,
      this.dateTimeText);

  getDateTimeText() {
    return dateTimeText;
  }
}
