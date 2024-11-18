import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/data/dtos/task.dto.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/data/model/task_model.dart';
part 'task_detail.event.dart';
part 'task_detail.state.dart';

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  final TaskRepository _taskRepository;

  TaskDetailBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(const TaskDetailState.loading()) {
    on<HomeTaskDetailClose>(_onCloseDown);
    on<HomeDetailTaskOpen>(_onOpen);
    on<DetailPropertiesChange>(_onChangeProperties);
    on<HomeDetailTaskEdit>(_onOpenEdit);
    on<HomeDetailTaskCancelEdit>(_onCancelEdit);
    on<HomeDetailTaskSaveEdit>(_onSaveEdit);
    on<HomeDetailTaskDelete>(_onDeleteTask);
    on<HomeDetailTaskCompleteTask>(_onCompleteTask);
  }

  void _onCloseDown(HomeTaskDetailClose event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(status: DetailHomeStatus.finished));
  }

  void _onOpen(HomeDetailTaskOpen event, Emitter<TaskDetailState> emit) async {
    emit(state.copyWith(status: DetailHomeStatus.initial, task: event.task));
  }

  void _onCompleteTask(
      HomeDetailTaskCompleteTask event, Emitter<TaskDetailState> emit) async {
    if (state.task == null || event.status == null) {
      return;
    }

    final TaskDTO data =
        state.task!.copyWith(status: event.status).toResponse();

    emit(state.copyWith(status: DetailHomeStatus.loading));
    try {
      await _taskRepository.editTask(data, state.task!.id);
      emit(state.copyWith(
        status: DetailHomeStatus.finished,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: DetailHomeStatus.failed));
    }
  }

  void _onChangeProperties(
      DetailPropertiesChange event, Emitter<TaskDetailState> emit) async {
    if (state.task == null) {
      return;
    }

    if (event.date == null && event.time == null && event.priority == null) {
      return;
    }

    final DateTime date = (event.date ?? state.task!.deadTime)
        .at(event.time ?? TimeOfDay.fromDateTime(state.task!.deadTime));

    if (state.task!.deadTime.isSameDate(date) &&
        state.task!.priority == event.priority) {
      emit(
        state.copyWith(
          status: DetailHomeStatus.initial,
        ),
      );
      return;
    }

    final TaskDTO data = state.task!
        .copyWith(deadTime: date, priority: event.priority)
        .toResponse();

    emit(state.copyWith(status: DetailHomeStatus.loading));

    await Future.delayed(const Duration(seconds: 3));
    try {
      final editedTask = await _taskRepository.editTask(data, state.task!.id);

      emit(
        state.copyWith(
          task: editedTask,
          status: DetailHomeStatus.initial,
        ),
      );
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: DetailHomeStatus.failed));
    }
  }

  void _onOpenEdit(HomeDetailTaskEdit event, Emitter<TaskDetailState> emit) {
    emit(TaskDetailStateEditing(
        task: state.task, focusOnTitle: event.focusOnTitle));
  }

  void _onCancelEdit(
      HomeDetailTaskCancelEdit event, Emitter<TaskDetailState> emit) {
    emit(state.copyWith(status: DetailHomeStatus.initial));
  }

  void _onSaveEdit(
      HomeDetailTaskSaveEdit event, Emitter<TaskDetailState> emit) async {
    if (state.task == null) {
      return;
    }

    if (event.taskName == null || event.taskName!.isEmpty) {
      return;
    }

    final TaskDTO data = state.task!
        .copyWith(name: event.taskName, description: event.taskDescription)
        .toResponse();

    emit(state.copyWith(status: DetailHomeStatus.loading));

    try {
      final responseTask = await _taskRepository.editTask(data, state.task!.id);

      emit(state.copyWith(
        status: DetailHomeStatus.initial,
        task: responseTask,
      ));
    } catch (e) {
      emit(state.copyWith(status: DetailHomeStatus.failed));
    }
  }

  Future<void> _onDeleteTask(
      HomeDetailTaskDelete event, Emitter<TaskDetailState> emit) async {
    if (state.task == null) {
      return;
    }
    emit(state.copyWith(status: DetailHomeStatus.loading));

    try {
      await _taskRepository.deleteTask(state.task!.id);
      emit(state.copyWith(
        status: DetailHomeStatus.finished,
      ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: DetailHomeStatus.failed));
    }
  }
}
