import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/data/dtos/task.dto.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/data/task_model.dart';
part 'home_detail_task.event.dart';
part 'home_detail_task.state.dart';

class HomeDetailTaskBloc
    extends Bloc<HomeDetailTaskEvent, HomeDetailTaskState> {
  final TaskRepository _taskRepository;

  HomeDetailTaskBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(const HomeDetailTaskState.initial()) {
    on<HomeTaskDetailClose>(_onCloseDown);
    on<HomeDetailTaskOpen>(_onOpen);
    on<HomeDetailTaskChangeDateTime>(_onChangeDateTime);
    on<HomeDetailTaskEdit>(_onOpenEdit);
    on<HomeDetailTaskCancelEdit>(_onCancelEdit);
    on<HomeDetailTaskSaveEdit>(_onSaveEdit);
    on<HomeDetailTaskDelete>(_onDeleteTask);
    on<HomeDetailTaskCompleteTask>(_onCompleteTask);
  }

  void _onCloseDown(
      HomeTaskDetailClose event, Emitter<HomeDetailTaskState> emit) {
    emit(state.copyWith(status: DetailHomeStatus.finished));
  }

  void _onOpen(
      HomeDetailTaskOpen event, Emitter<HomeDetailTaskState> emit) async {
    emit(state.copyWith(status: DetailHomeStatus.loading));

    emit(state.copyWith(status: DetailHomeStatus.initial, task: event.task));
  }

  void _onCompleteTask(HomeDetailTaskCompleteTask event,
      Emitter<HomeDetailTaskState> emit) async {
    if (state.task == null || event.status == null) {
      return;
    }

    final TaskDTO data =
        state.task!.copyWith(status: event.status).toResponse();

    emit(state.copyWith(status: DetailHomeStatus.loading));
    try {
      await _taskRepository.editTask(data, state.task!.id);
      emit(state.copyWith(status: DetailHomeStatus.finished, isEdited: true));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: DetailHomeStatus.failed));
    }
  }

  void _onChangeDateTime(HomeDetailTaskChangeDateTime event,
      Emitter<HomeDetailTaskState> emit) async {
    if (state.task == null) {
      return;
    }

    if (event.date == null && event.time == null) {
      return;
    }

    final DateTime date = (event.date ?? state.task!.deadTime)
        .at(event.time ?? TimeOfDay.fromDateTime(state.task!.deadTime));

    final TaskDTO data = state.task!.copyWith(deadTime: date).toResponse();

    emit(state.copyWith(status: DetailHomeStatus.loading));
    try {
      final editedTask = await _taskRepository.editTask(data, state.task!.id);

      emit(
        state.copyWith(
            task: editedTask, status: DetailHomeStatus.initial, isEdited: true),
      );
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: DetailHomeStatus.failed));
    }
  }

  void _onOpenEdit(
      HomeDetailTaskEdit event, Emitter<HomeDetailTaskState> emit) {
    emit(state.copyWith(status: DetailHomeStatus.editing));
  }

  void _onCancelEdit(
      HomeDetailTaskCancelEdit event, Emitter<HomeDetailTaskState> emit) {
    emit(state.copyWith(status: DetailHomeStatus.initial));
  }

  void _onSaveEdit(
      HomeDetailTaskSaveEdit event, Emitter<HomeDetailTaskState> emit) async {
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
          isEdited: true));
    } catch (e) {
      emit(state.copyWith(status: DetailHomeStatus.failed));
    }
  }

  Future<void> _onDeleteTask(
      HomeDetailTaskDelete event, Emitter<HomeDetailTaskState> emit) async {
    if (state.task == null) {
      return;
    }
    emit(state.copyWith(status: DetailHomeStatus.loading));

    try {
      await _taskRepository.deleteTask(state.task!.id);
      emit(state.copyWith(status: DetailHomeStatus.finished, isEdited: true));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: DetailHomeStatus.failed));
    }
  }
}
