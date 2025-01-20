import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/data/dtos/task.dto.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/common/timeofday_extension.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
part 'task_create.event.dart';
part 'task_create.state.dart';

class TaskCreateBloc extends Bloc<TaskCreateEvent, TaskCreateState> {
  final TaskRepository _taskRepository;
  TaskCreateBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(TaskCreateState.initial()) {
    on<NewHomeDateTapped>(_onDateTapped);
    on<NewHomeTimeTapped>(_onTimeTapped);
    on<NewHomeSubmitTapped>(_onSubmitTapped);
    on<NewHomePriorityTapped>(_onPriorityTapped);
  }

  void _onDateTapped(NewHomeDateTapped event, Emitter<TaskCreateState> emit) {
    if (event.date == null) {
      return;
    }
    final DateTime newDate = event.date!;
    if (state.date.isSameDate(newDate)) {
      return;
    }
    final newState = state.copyWith(
      date: newDate,
      dateLabel: newDate.relativeToToday(),
    );
    emit(newState);
  }

  void _onPriorityTapped(
      NewHomePriorityTapped event, Emitter<TaskCreateState> emit) {
    if (event.priority == null) {
      return;
    }
    final int newPriority = event.priority!;
    if (state.priority == newPriority) return;

    final newState = state.copyWith(
      priority: newPriority,
    );
    emit(newState);
  }

  void _onTimeTapped(NewHomeTimeTapped event, Emitter<TaskCreateState> emit) {
    if (event.time == null) {
      return;
    }

    final TimeOfDay newTime = event.time!;

    if (newTime.isSameTimeFromDate(state.date)) {
      return;
    }

    final newState =
        state.copyWith(time: newTime, timeLabel: newTime.toLabel());
    emit(newState);
  }

  void _onSubmitTapped(
      NewHomeSubmitTapped event, Emitter<TaskCreateState> emit) async {
    if (event.missionName == null || event.missionName!.isEmpty) {
      return;
    }

    emit(state.copyWith(
        status: NewHomeStatus.loading,
        missionName: event.missionName,
        description: event.description!.isEmpty ? "" : event.description!));

    final TaskDTO data = state.toDTO();

    try {
      await _taskRepository.createTask(data);
      emit(state.copyWith(status: NewHomeStatus.initial));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: NewHomeStatus.failure));
    }
  }
}
