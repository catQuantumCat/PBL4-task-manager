import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CalendarView();
  }
}

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  late PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Upcoming",
          style: context.appTextStyles.subHeading1,
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
              onVerticalSwipe: (swipeDirection) {
                _pageController.jumpToPage(_pageController.page!.toInt() + 1);
              },
              onCalendarCreated: (pageController) {
                _pageController = pageController;
                _pageController.addListener(() {
                  if (_pageController.position.userScrollDirection ==
                      ScrollDirection.reverse) {
                    log(_pageController.page.toString(),
                        name: "Page controller");
                    _pageController
                        .jumpToPage(_pageController.page!.toInt() + 1);
                  } else if (_pageController.position.userScrollDirection ==
                      ScrollDirection.forward) {
                    _pageController
                        .jumpToPage(_pageController.page!.toInt() - 1);
                  }
                });
              },
              simpleSwipeConfig: const SimpleSwipeConfig(
                  swipeDetectionBehavior: SwipeDetectionBehavior.singularOnEnd),
              calendarFormat: _calendarFormat,
              availableGestures: AvailableGestures.verticalSwipe,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onPageChanged: (focusedDay) => log,
              selectedDayPredicate: (day) => isSameDay(_focusedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });

                //bloc get date to show
              },
              onFormatChanged: (format) => setState(() {
                    _calendarFormat = format;
                  }),
              firstDay: DateTime.now(),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay),
        ],
      ),
    );
  }
}
