import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  bool isSameTime(TimeOfDay anotherTime) {
    return (hour == anotherTime.hour && minute == anotherTime.minute);
  }

  bool isSameTimeFromDate(DateTime anotherDate) {
    return (hour == anotherDate.hour && minute == anotherDate.minute);
  }

  String toLabel() {
    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  }
}
