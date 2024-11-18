import 'package:flutter/material.dart';

enum PriorityEnum {
  high(3, 'Priority 3'),
  medium(2, 'Priority 2'),
  low(1, 'Priority 1'),
  none(0, 'No priority');

  final int key;
  final String label;

  const PriorityEnum(this.key, this.label);

  static String getLabel(int key) {
    return PriorityEnum.values
        .firstWhere((val) => val.key == key, orElse: () => PriorityEnum.none)
        .label;
  }
}

// enum ScheduleEnum {
//   today("Today", Icons.today),
//   tomorrow("Tomorrow", Icons.wb_sunny_outlined),
//   // laterWeek("Later this week", Icons.calendar_month_rounded),
//   // weekend("This weekend", Icons.weekend_outlined),
//   // nextWeek("Next week")
  
  
//   ;

//   final String label;
//   // final IconData icon;

//   const ScheduleEnum(this.label);
// }
