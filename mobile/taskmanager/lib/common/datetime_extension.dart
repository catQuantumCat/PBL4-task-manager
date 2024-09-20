import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  DateTime at(TimeOfDay time) {
    return copyWith(hour: time.hour, minute: time.minute);
  }

  String relativeToToday() {
    final DateTime today = DateTime.now();
    if (DateUtils.isSameDay(this, today)) {
      return "Today";
    }

    if (DateUtils.isSameDay(this, today.add(const Duration(days: 1)))) {
      return "Tomorrow";
    }

    return DateFormat("d MMM").format(this);
  }

  String currentTimeString() {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }

  bool isSameDate(DateTime incomingDate) {
    return DateUtils.isSameDay(this, incomingDate);
  }
}
