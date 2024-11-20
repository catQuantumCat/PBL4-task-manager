import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:intl/intl.dart';

import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:taskmanager/common/context_extension.dart';

import 'package:taskmanager/modules/calendar/bloc/calendar_bloc.dart';

class CalendarTableWidget extends StatefulWidget {
  const CalendarTableWidget(
      {super.key,
      required DateTime focusedDay,
      required void Function(DateTime selectedDate) onDateChanged})
      : _focusedDay = focusedDay,
        _onDateChanged = onDateChanged;
  final DateTime _focusedDay;

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

  Icon _getIcon() {
    switch (_calendarFormat) {
      case CalendarFormat.week:
        return const Icon(
          Icons.keyboard_arrow_right_rounded,
        );
      case CalendarFormat.month:
        return Icon(
          Icons.keyboard_arrow_down_rounded,
          color: context.palette.primaryColor,
        );
      default:
        return Icon(
          Icons.calendar_today,
          color: context.palette.primaryColor,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        onVerticalSwipe: (sw) => _onVerticalSwipe(sw),
        availableCalendarFormats: const {
          CalendarFormat.week: "",
          CalendarFormat.month: ""
        },
        calendarBuilders: CalendarBuilders(
          headerTitleBuilder: (context, day) => Row(children: [
            Text(
              DateFormat.yMMM().format(day),
              style: context.appTextStyles.subHeading2,
            ),
            IconButton(onPressed: _onFormatButtonTapped, icon: _getIcon()),
            if (!isSameDay(widget._focusedDay, DateTime.now()))
              IconButton(
                  onPressed: _onReturnTodayTapped,
                  icon: const Icon(
                    Icons.today,
                  ))
          ]),
        ),
        headerStyle: const HeaderStyle(
            headerPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            formatButtonVisible: false,
            rightChevronVisible: false,
            leftChevronVisible: false),
        calendarStyle: const CalendarStyle(
            tablePadding: EdgeInsets.symmetric(horizontal: 6)),
        calendarFormat: _calendarFormat,
        availableGestures: AvailableGestures.all,
        startingDayOfWeek: StartingDayOfWeek.monday,
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
