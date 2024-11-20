import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

import 'package:intl/intl.dart';

import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:taskmanager/common/context_extension.dart';

class CalendarTableWidget extends StatefulWidget {
  const CalendarTableWidget(
      {super.key,
      required DateTime focusedDay,
      required Set<DateTime> deadlineSet,
      required void Function(DateTime selectedDate) onDateChanged})
      : _focusedDay = focusedDay,
        _onDateChanged = onDateChanged,
        _deadlineSet = deadlineSet;
  final DateTime _focusedDay;

  final Set<DateTime> _deadlineSet;

  final void Function(DateTime selectedDate) _onDateChanged;

  @override
  State<CalendarTableWidget> createState() => _CalendarTableWidgetState();
}

class _CalendarTableWidgetState extends State<CalendarTableWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.week;

  void _onFormatButtonTapped() {
    setState(() {
      _calendarFormat = _calendarFormat == CalendarFormat.month
          ? CalendarFormat.week
          : CalendarFormat.month;
    });
  }

  void _onReturnTodayTapped() {
    widget._onDateChanged(DateTime.now());
  }

  void _onVerticalSwipe(SwipeDirection swipeDirection) {
    if (_calendarFormat == CalendarFormat.week &&
        swipeDirection == SwipeDirection.down) {
      setState(() {
        _calendarFormat = CalendarFormat.month;
      });
    }
  }

  Widget _getCalendarHeader(DateTime day) {
    final headerForgroundColor = _calendarFormat == CalendarFormat.month
        ? context.palette.primaryColor
        : context.palette.normalText;

    final calendarFormatIcon = _calendarFormat == CalendarFormat.month
        ? Icons.keyboard_arrow_down_rounded
        : Icons.keyboard_arrow_right_rounded;

    return Row(children: [
      Text(
        DateFormat.yMMM().format(day),
        style: context.appTextStyles.subHeading2
            .copyWith(color: headerForgroundColor),
      ),
      IconButton(
          onPressed: _onFormatButtonTapped,
          icon: Icon(
            calendarFormatIcon,
            color: headerForgroundColor,
          )),
      if (!isSameDay(widget._focusedDay, DateTime.now()))
        IconButton(
            onPressed: _onReturnTodayTapped,
            icon: Icon(
              Icons.today,
              color: context.palette.primaryColor,
            ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        onVerticalSwipe: (sw) => _onVerticalSwipe(sw),
        eventLoader: (day) => widget._deadlineSet
            .where((deadline) =>
                isSameDay(deadline, day) &&
                !isSameDay(deadline, widget._focusedDay))
            .toList(),
        availableCalendarFormats: const {
          CalendarFormat.week: "",
          CalendarFormat.month: ""
        },
        calendarBuilders: CalendarBuilders(
          headerTitleBuilder: (context, day) => _getCalendarHeader(day),
        ),
        headerStyle: const HeaderStyle(
            headerPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            formatButtonVisible: false,
            rightChevronVisible: false,
            leftChevronVisible: false),
        calendarStyle: CalendarStyle(
            defaultTextStyle: context.appTextStyles.body2,
            selectedTextStyle: context.appTextStyles.body2
                .copyWith(color: context.palette.onPrimary),
            selectedDecoration: BoxDecoration(
                color: context.palette.primaryColor, shape: BoxShape.circle),
            todayDecoration: const BoxDecoration(shape: BoxShape.circle),
            todayTextStyle: context.appTextStyles.body2
                .copyWith(color: context.palette.primaryColor),
            markerSize: 7,
            markersMaxCount: 1,
            markerDecoration: BoxDecoration(
                color: context.palette.hintTextField, shape: BoxShape.circle)),
        calendarFormat: _calendarFormat,
        availableGestures: AvailableGestures.all,
        startingDayOfWeek: StartingDayOfWeek.monday,
        onPageChanged: (focusedDay) => _calendarFormat == CalendarFormat.week
            ? widget._onDateChanged(focusedDay)
            : null,
        selectedDayPredicate: (day) {
          final toReturn = isSameDay(widget._focusedDay, day);

          return toReturn;
        },
        onDaySelected: (selectedDay, focusedDay) {
          widget._onDateChanged(focusedDay);
        },
        firstDay: DateTime.now(),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: widget._focusedDay);
  }
}
