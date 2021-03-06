import 'package:event_checker/event_detail.dart';
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
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                subtitle: Text(events[item].getDateTimeText(),
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                trailing: const Icon(Icons.navigate_next),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailPage(event: events[item])));
                }
              ),
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
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
            awaitNewEvent();
        }
    );
  }

  void awaitNewEvent() async {

    Event newEvent = await Navigator.push(context, MaterialPageRoute(builder: (_) => AddEvent()));

    setState(() {

      events.add(newEvent);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Checker")
      ),
      body: buildList(),
            floatingActionButton: buildActionButton(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );
  }
}