import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/data/datasources/task/remote/task_remote.datasource.dart';
import 'package:taskmanager/data/dtos/task.dto.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/data/task_model.dart';
part 'detail_home.event.dart';
part 'detail_home.state.dart';

class DetailHomeBloc extends Bloc<DetailHomeEvent, DetailHomeState> {
  final repository = TaskRepository(dataSource: TaskRemoteDataSource());

  DetailHomeBloc() : super(const DetailHomeState.initial()) {
    on<DetailHomeClose>(_onCloseDown);
    on<DetailHomeOpen>(_onOpen);
    on<DetailHomeEditTask>(_onEditTask);
    on<DetailHomeOpenEdit>(_onOpenEdit);
    on<DetailHomeCancelEdit>(_onCancelEdit);
    on<DetailHomeSaveEdit>(_onSaveEdit);
  }

  void _onCloseDown(DetailHomeClose event, Emitter<DetailHomeState> emit) {
    print("Close down received");
  }

  void _onOpen(DetailHomeOpen event, Emitter<DetailHomeState> emit) {
    emit(DetailHomeState.loaded(task: event.task));
  }

  void _onEditTask(
      DetailHomeEditTask event, Emitter<DetailHomeState> emit) async {
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
      emit(DetailHomeState.loaded(task: editedTask));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: DetailHomeStatus.error));
    }
  }

  void _onOpenEdit(DetailHomeOpenEdit event, Emitter<DetailHomeState> emit) {
    emit(state.copyWith(status: DetailHomeStatus.editing));
  }

  void _onCancelEdit(
      DetailHomeCancelEdit event, Emitter<DetailHomeState> emit) {
    emit(state.copyWith(status: DetailHomeStatus.loaded));
  }

  void _onSaveEdit(
      DetailHomeSaveEdit event, Emitter<DetailHomeState> emit) async {
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
      emit(DetailHomeState.loaded(task: responseTask));
    } catch (e) {
      emit(state.copyWith(status: DetailHomeStatus.error));
    }
  }
}
