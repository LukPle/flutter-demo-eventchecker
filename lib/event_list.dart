import 'package:flutter/material.dart';
import 'event.dart';
import 'event_add.dart';

class EventList extends StatefulWidget {

  @override
  EventListState createState() => EventListState();
}

class EventListState extends State<EventList> {

  List<Event> events = <Event>[];

  Widget buildList() {

    if(events.isNotEmpty) {

      return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: events.length,

          itemBuilder: (context, item) {

            return Card(
              child: ListTile(
                title: Text(events[item].getTitle(),
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
              ),
            );
          }
      );
    }
    else {

      return const Center(
        child: Text("No upcoming Events",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
      );
    }
  }

  Widget buildActionButton() {

    return FloatingActionButton.extended(
        label: const Text("Add New Event",
            style: TextStyle(fontSize: 16)),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddEvent()));
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Checker")
      ),
      body: buildList(),
            floatingActionButton: buildActionButton(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}