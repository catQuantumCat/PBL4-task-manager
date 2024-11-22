import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/common/constants/ui_constant.dart';
import 'package:taskmanager/common/context_extension.dart';

class CalendarEmptyWidget extends StatelessWidget {
  const CalendarEmptyWidget({super.key, required DateTime selectedDate})
      : _selectedDate = selectedDate;

  final DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.calendar_today_rounded,
          color: context.palette.disabledButtonLabel,
          size: UIConstant.fullPageIconSize,
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          "No task for ${DateFormat.MMMd().format(_selectedDate)}",
          style: context.appTextStyles.disabledSubHeading1,
        ),
      ],
    );
  }
}
