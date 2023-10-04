import 'package:flutter/material.dart';
import '../data/event.dart';

class EventDetailPage extends StatefulWidget {

  final Event event;
  const EventDetailPage({Key? key, required this.event}) : super(key: key);

  @override
  EventDetailPageState createState() => EventDetailPageState();
}

class EventDetailPageState extends State<EventDetailPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: Text(widget.event.title)
        ),
        body: Card(
            child: Text(widget.event.description)
        )
    );
  }
}