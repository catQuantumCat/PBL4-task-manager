import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/data/datasources/task/remote/task_remote.datasource.dart';
import 'package:taskmanager/data/dtos/task.dto.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/data/task_model.dart';
part 'home_detail_task.event.dart';
part 'home_detail_task.state.dart';

class HomeDetailTaskBloc
    extends Bloc<HomeDetailTaskEvent, HomeDetailTaskState> {
  final repository = TaskRepository(dataSource: TaskRemoteDataSource());

  HomeDetailTaskBloc() : super(const HomeDetailTaskState.initial()) {
    on<HomeTaskDetailClose>(_onCloseDown);
    on<HomeDetailTaskOpen>(_onOpen);
    on<HomeDetailTaskChangeMetadata>(_onEditTask);
    on<HomeDetailTaskEdit>(_onOpenEdit);
    on<HomeDetailTaskCancelEdit>(_onCancelEdit);
    on<HomeDetailTaskSaveEdit>(_onSaveEdit);
  }

  void _onCloseDown(
      HomeTaskDetailClose event, Emitter<HomeDetailTaskState> emit) {
    print("Close down received");
  }

  void _onOpen(HomeDetailTaskOpen event, Emitter<HomeDetailTaskState> emit) {
    emit(HomeDetailTaskState.loaded(task: event.task));
  }

  void _onEditTask(HomeDetailTaskChangeMetadata event,
      Emitter<HomeDetailTaskState> emit) async {
    if (state.task == null) {
      return;
    }

    if (event.date == null && event.time == null && event.status == null) {
      return;
    }

    final DateTime date = (event.date ?? state.task!.deadTime)
        .at(event.time ?? TimeOfDay.fromDateTime(state.task!.deadTime));

    final TaskDTO data =
        state.task!.copyWith(deadTime: date, status: event.status).toResponse();

    emit(state.copyWith(status: DetailHomeStatus.loading));
    try {
      final editedTask = await repository.editTask(data, state.task!.id);
      emit(HomeDetailTaskState.loaded(task: editedTask));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: DetailHomeStatus.error));
    }
  }

  void _onOpenEdit(
      HomeDetailTaskEdit event, Emitter<HomeDetailTaskState> emit) {
    emit(state.copyWith(status: DetailHomeStatus.editing));
  }

  void _onCancelEdit(
      HomeDetailTaskCancelEdit event, Emitter<HomeDetailTaskState> emit) {
    emit(state.copyWith(status: DetailHomeStatus.loaded));
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
      final responseTask = await repository.editTask(data, state.task!.id);
      emit(HomeDetailTaskState.loaded(task: responseTask));
    } catch (e) {
      emit(state.copyWith(status: DetailHomeStatus.error));
    }
  }
}
