import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/data/datasources/task/remote/task_remote.datasource.dart';
import 'package:taskmanager/data/dtos/task.dto.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/common/timeofday_extension.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
part 'new_home.event.dart';
part 'new_home.state.dart';

class NewHomeBloc extends Bloc<NewHomeEvent, NewHomeState> {
  final repository = TaskRepository(dataSource: TaskRemoteDataSource());
  NewHomeBloc() : super(NewHomeState.initial()) {
    on<NewHomeDateTapped>(_onDateTapped);
    on<NewHomeTimeTapped>(_onTimeTapped);
    on<NewHomeSubmitTapped>(_onSubmitTapped);
  }

  void _onDateTapped(NewHomeDateTapped event, Emitter<NewHomeState> emit) {
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

  void _onTimeTapped(NewHomeTimeTapped event, Emitter<NewHomeState> emit) {
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
      NewHomeSubmitTapped event, Emitter<NewHomeState> emit) async {
    if (event.missionName == null || event.missionName!.isEmpty) {
      return;
    }

    emit(state.copyWith(
        status: NewHomeStatus.loading,
        missionName: event.missionName,
        description: event.description!.isEmpty ? null : event.description!));

    final TaskDTO data = state.toDTO();

    try {
      await repository.createTask(data);
      emit(state.copyWith(status: NewHomeStatus.success));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: NewHomeStatus.failure));
    }
  }
}
