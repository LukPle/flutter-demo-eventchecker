import 'package:event_checker/components/category_preview.dart';
import 'package:event_checker/screens/event_detail.dart';
import 'package:event_checker/data/event_types.dart';
import 'package:event_checker/res/strings.dart';
import 'package:event_checker/res/styles.dart';
import 'package:flutter/material.dart';
import '../data/event.dart';
import 'event_add.dart';

class EventList extends StatefulWidget {
  @override
  EventListState createState() => EventListState();
}

class EventListState extends State<EventList> {
  List<Event> listedEvents = <Event>[];
  List<Event> allEvents = <Event>[];
  bool isInSearchMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: isInSearchMode
              ? buildSearchView()
              : const Text(AppStrings.appName),
          actions: [
            IconButton(
                onPressed: () => setState(() {
                      isInSearchMode = !isInSearchMode;
                      listedEvents = allEvents;
                    }),
                icon: Icon(isInSearchMode ? Icons.clear : Icons.search)),
          ],
        ),
        body: SafeArea(
            child: listedEvents.isNotEmpty ? buildList() : buildPreview()),
        floatingActionButton: buildActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  Widget buildPreview() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.playlist_remove_rounded, size: 60),
          SizedBox(height: 20),
          Text(AppStrings.previewLabel, style: AppTextStyles.heavyTextStyle)
        ],
      ),
    );
  }

  Widget buildSearchView() {
    return TextField(
      autofocus: true,
      cursorColor: Colors.white,
      style: AppTextStyles().searchTextStyle(false),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: AppStrings.searchLabel,
        hintStyle: AppTextStyles().searchTextStyle(true),
      ),
      onChanged: (String query) {
        searchList(query);
      },
    );
  }

  Widget buildList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              padding: const EdgeInsets.all(10),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listedEvents.length,
              itemBuilder: (context, item) {
                return buildEventCard(item);
              }),
          const SizedBox(height: 85),
        ],
      ),
    );
  }

  Widget buildEventCard(int item) {
    return Card(
      child: ListTile(
          leading: buildCategoryPreview(
              context, getEventTypeIcon(listedEvents[item].eventType)),
          title: Text(listedEvents[item].title,
              style: AppTextStyles.heavyTextStyle),
          subtitle: Text(listedEvents[item].getDateTimeText(),
              style: AppTextStyles.textStyle),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EventDetailPage(event: listedEvents[item])));
          }),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorders.borderRadius,
      ),
    );
  }

  Widget buildActionButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: FloatingActionButton.extended(
          label: const Text(AppStrings.addButtonLabel,
              style: AppTextStyles.buttonStyle),
          icon: const Icon(Icons.add),
          onPressed: () {
            awaitNewEvent();
          }),
    );
  }

  void searchList(String query) {
    setState(() {
      listedEvents = allEvents
          .where(
              (item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      listedEvents.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    });
  }

  void awaitNewEvent() async {
    Event newEvent = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => AddEvent()));

    setState(() {
      allEvents.add(newEvent);
      allEvents.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    });
  }
}
