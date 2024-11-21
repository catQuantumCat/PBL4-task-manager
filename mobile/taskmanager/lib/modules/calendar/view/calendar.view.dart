import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/common/widget/common_list_section.dart';

import 'package:taskmanager/common/widget/common_title_appbar.widget.dart';

import 'package:taskmanager/modules/calendar/bloc/calendar_bloc.dart';
import 'package:taskmanager/modules/calendar/widget/calendar_table.widget.dart';
import 'package:taskmanager/modules/home/bloc/home_bloc.dart';

import 'package:taskmanager/modules/task/view/task_list/task_list.view.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CalendarView();
  }
}

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  void _onDateTapped(DateTime date, BuildContext context) {
    if (isSameDay(date, context.read<CalendarBloc>().state.selectedDate)) {
      return;
    }

    context.read<CalendarBloc>().add(CalendarDateSelected(selectedDate: date));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        return CommonTitleAppbar(
          title: "Upcoming",
          compactEnabled: true,
          stickyWidget: CalendarTableWidget(
            focusedDay: context.read<CalendarBloc>().state.selectedDate,
            deadlineSet: context.read<CalendarBloc>().state.fullTask,
            onDateChanged: (selectedDate) =>
                _onDateTapped(selectedDate, context),
          ),
          section: [
            if (isSameDay(state.selectedDate, DateTime.now()) &&
                context.read<HomeBloc>().state.overdueList.isNotEmpty)
              CommonListSection(
                title: "Overdue",
                child: TaskListView(
                  taskList: context.read<HomeBloc>().state.overdueList,
                ),
              ),
            CommonListSection(
              title: state.selectedDate.dateToString(),
              collapsedEnabled: false,
              child: TaskListView(
                  taskList: context.read<CalendarBloc>().state.filteredTask),
            ),
          ],

          // TaskListView(taskList: context.read<HomeBloc>().state.overdueList),
        );
      },
    );
  }
}
