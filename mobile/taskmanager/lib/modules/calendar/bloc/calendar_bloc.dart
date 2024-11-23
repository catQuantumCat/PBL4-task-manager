import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final TaskRepository _taskRepo;
  CalendarBloc({required TaskRepository taskRepository})
      : _taskRepo = taskRepository,
        super(CalendarInitial()) {
    on<CalendarOpen>(_onOpen);
    on<CalendarDateSelected>(_onDateSelected);
    add(CalendarDateSelected(selectedDate: state.selectedDate));
  }

  Future<void> _onOpen(CalendarOpen event, Emitter<CalendarState> emit) async {
    await emit.forEach(_taskRepo.getTaskStream(), onData: (taskList) {
      log("UPDATED", name: "OnCalendarOpens");

      final filteredTask = taskList
          .where((task) => isSameDay(task.deadTime, state.selectedDate))
          .toList();

      return state.copyWith(
          filteredTask: filteredTask,
          fullTask: taskList.map((task) => task.deadTime).toSet());
    }, onError: (error, stackTrace) {
      log(error.toString());
      return CalendarFailed(errorMessage: error.toString());
    });
  }

  Future<void> _onDateSelected(
      CalendarDateSelected event, Emitter<CalendarState> emit) async {
    emit(
      state.copyWith(
        selectedDate: event.selectedDate,
        filteredTask: _taskRepo
            .getTaskList()
            .where((task) => isSameDay(task.deadTime, event.selectedDate))
            .toList(),
      ),
    );
  }
}
