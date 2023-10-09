import 'package:event_checker/components/category_preview.dart';
import 'package:event_checker/components/datetime_text_creator.dart';
import 'package:event_checker/data/user_name.dart';
import 'package:event_checker/res/colors.dart';
import 'package:event_checker/screens/event_detail.dart';
import 'package:event_checker/data/event_types.dart';
import 'package:event_checker/res/strings.dart';
import 'package:event_checker/res/styles.dart';
import 'package:flutter/material.dart';
import 'package:event_checker/data/event.dart';
import 'event_add.dart';

class EventList extends StatefulWidget {
  @override
  EventListState createState() => EventListState();
}

class EventListState extends State<EventList> {
  List<Event> listedEvents = <Event>[];
  List<Event> allEvents = <Event>[];
  bool isInSearchMode = false;
  DateTime now = DateTime.now();
  String username = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        String usernameData = await getUsername(context);
        setState(() {
          username = usernameData;
        });
      },
    );
  }

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
            child: listedEvents.isNotEmpty ? buildLists() : buildPreview()),
        floatingActionButton: buildActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  Widget buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            AppStrings().headerDateTime(getWeekdayName(now.weekday),
                convertDateTimeToText(now, excludeTime: true)),
            style: AppTextStyles()
                .fadedTextStyle(MediaQuery.of(context).platformBrightness)),
        const SizedBox(height: 3),
        Text(AppStrings().headerGreeting(now, username),
            style: AppTextStyles.greetingHeading),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget buildPreview() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.playlist_remove_rounded, size: 60),
          SizedBox(height: 20),
          Text(AppStrings.previewLabel, style: AppTextStyles.heavyTextStyle),
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

  Widget buildLists() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            isInSearchMode ? const SizedBox.shrink() : buildHeader(),
            buildEventListForWeek(),
            const SizedBox(height: 25),
            buildEventListForLater(),
            const SizedBox(height: 85),
          ],
        ),
      ),
    );
  }

  Widget buildEventListForWeek() {
    return getWeeklyEvents().isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(AppStrings.weeklyEventsHeading,
                  style: AppTextStyles.headingStyle),
              const SizedBox(height: 10),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: getWeeklyEvents().length,
                  itemBuilder: (context, item) {
                    return buildEventCard(getWeeklyEvents(), item);
                  }),
            ],
          )
        : buildEmptyCard();
  }

  Widget buildEventListForLater() {
    return getLaterEvents().isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(AppStrings.laterEventsHeading,
                  style: AppTextStyles.headingStyle),
              const SizedBox(height: 10),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: getLaterEvents().length,
                  itemBuilder: (context, item) {
                    return buildEventCard(getLaterEvents(), item);
                  }),
            ],
          )
        : const SizedBox.shrink();
  }

  Widget buildEventCard(List<Event> events, int item) {
    return Card(
      child: ListTile(
          leading: buildCategoryPreview(
              context, getEventTypeIcon(events[item].eventType)),
          title: Text(events[item].title, style: AppTextStyles.heavyTextStyle),
          subtitle: Text(events[item].getDateTimeText(),
              style: AppTextStyles.textStyle),
          trailing: const Icon(Icons.navigate_next),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EventDetailPage(event: events[item])));
          }),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorders.borderRadius,
      ),
    );
  }

  Widget buildEmptyCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: MediaQuery.of(context).platformBrightness == Brightness.light
            ? Colors.white
            : Colors.white10,
        border: Border.all(
          width: 1,
          color: MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.grey
              : Colors.white24,
        ),
        borderRadius: AppBorders.borderRadius,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 15),
          Text(
            AppStrings.noEventsAvailableLabel,
            style: AppTextStyles.heavyTextStyle,
          ),
        ],
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
          backgroundColor:
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? AppColors.primaryLight
                  : AppColors.primaryDark,
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

  DateTime getStartOfWeek() {
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
  }

  DateTime getEndOfWeek() {
    DateTime endOfWeek =
        now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
    return DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59);
  }

  List<Event> getWeeklyEvents() {
    return listedEvents
        .where((item) =>
            item.dateTime.isAfter(getStartOfWeek()) &&
            item.dateTime.isBefore(getEndOfWeek()))
        .toList();
  }

  List<Event> getLaterEvents() {
    return listedEvents
        .where((item) => item.dateTime.isAfter(getEndOfWeek()))
        .toList();
  }

  void awaitNewEvent() async {
    try {
      Event newEvent = await Navigator.push(
          context, MaterialPageRoute(builder: (_) => AddEvent()));

      setState(() {
        allEvents.add(newEvent);
        allEvents.sort((a, b) => a.dateTime.compareTo(b.dateTime));

        if (!isInSearchMode) {
          listedEvents = allEvents;
        }
      });
    } catch (exception) {
      return;
    }
  }
}
