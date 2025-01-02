import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskmanager/common/context_extension.dart';

import 'package:taskmanager/common/widget/common_list_section.dart';

import 'package:taskmanager/common/widget/common_title_appbar.widget.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/main.dart';

import 'package:taskmanager/modules/calendar/bloc/calendar_bloc.dart';
import 'package:taskmanager/modules/calendar/widget/calendar_empty.widget.dart';
import 'package:taskmanager/modules/calendar/widget/calendar_menu.button.dart';
import 'package:taskmanager/modules/calendar/widget/calendar_table.widget.dart';

import 'package:taskmanager/modules/task/view/task_list/task_list.view.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CalendarBloc>(
      create: (context) => CalendarBloc(taskRepository: getIt<TaskRepository>())
        ..add(const CalendarOpen()),
      child: const CalendarView(),
    );
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

  List<CommonListSection> _getSection(BuildContext context) {
    if (context.read<CalendarBloc>().state.filteredTask.isEmpty) {
      return [];
    }

    return [
      CommonListSection(
        title: DateFormat('dd MMM - EEEE')
            .format(context.read<CalendarBloc>().state.selectedDate),
        collapsedEnabled: false,
        child: TaskListPage(
            taskList: context.read<CalendarBloc>().state.filteredTask),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.palette.scaffoldBackground,
          body: CommonTitleAppbar(
            menuButton: const CalendarMenuButton(),
            title: "Upcoming",
            compactEnabled: true,
            stickyWidget: CalendarTableWidget(
              focusedDay: state.selectedDate,
              deadlineSet: state.fullTask,
              onDateChanged: (selectedDate) =>
                  _onDateTapped(selectedDate, context),
            ),
            section: _getSection(context),
            child: CalendarEmptyWidget(
              selectedDate: state.selectedDate,
            ),
          ),
        );
      },
    );
  }
}
