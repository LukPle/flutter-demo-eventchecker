class Event {

  String title;
  String description;
  DateTime dateTime;
  String dateTimeText;
  // date, time
  // location
  // type, outdoor, indoor

  Event(this.title, this.description, this.dateTime, this.dateTimeText);

  getTitle() {return title;}

  getDescription() {return description;}

  getDateTime() {return dateTime;}

  getDateTimeText() {return dateTimeText;}
}