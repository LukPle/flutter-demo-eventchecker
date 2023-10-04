import 'package:flutter/material.dart';

enum EventTypes { concert, party, travel, social, leisure, work, other }

String getEventTypeText(EventTypes eventType) {
  switch (eventType) {
    case EventTypes.concert:
      return "Concert";
    case EventTypes.party:
      return "Party";
    case EventTypes.travel:
      return "Travel";
    case EventTypes.social:
      return "Social";
    case EventTypes.leisure:
      return "Leisure";
    case EventTypes.work:
      return "Work";
    case EventTypes.other:
      return "Other";
  }
}

List<String> getAllEventTypeTexts() {
  List<String> eventTypeTexts = [];

  for (var eventType in EventTypes.values) {
    eventTypeTexts.add(getEventTypeText(eventType));
  }

  return eventTypeTexts;
}

EventTypes getEventTypeValue(String eventType) {
  switch (eventType) {
    case "Concert":
      return EventTypes.concert;
    case "Party":
      return EventTypes.party;
    case "Travel":
      return EventTypes.travel;
    case "Social":
      return EventTypes.social;
    case "Leisure":
      return EventTypes.leisure;
    case "Work":
      return EventTypes.work;
    case "Other":
      return EventTypes.other;
    default:
      throw FormatException("String $eventType not found.");
  }
}

IconData getEventTypeIcon(EventTypes eventType) {
  switch (eventType) {
    case EventTypes.concert:
      return Icons.music_note;
    case EventTypes.party:
      return Icons.celebration;
    case EventTypes.travel:
      return Icons.beach_access;
    case EventTypes.social:
      return Icons.people;
    case EventTypes.leisure:
      return Icons.spa;
    case EventTypes.work:
      return Icons.work;
    case EventTypes.other:
      return Icons.style;
  }
}
