import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:taskmanager/common/constants/hive_constant.dart';
import 'package:taskmanager/data/datasources/remote/task_remote.datasource.dart';
import 'package:taskmanager/data/dtos/task.dto.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/common/timeofday_extension.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
part 'home_new_task.event.dart';
part 'home_new_task.state.dart';

class HomeNewTaskBloc extends Bloc<HomeNewTaskEvent, HomeNewTaskStatus> {
  final repository = TaskRepository(
      dataSource:
          TaskRemoteDataSource(tokenBox: Hive.box(HiveConstant.boxName)));
  HomeNewTaskBloc() : super(HomeNewTaskStatus.initial()) {
    on<NewHomeDateTapped>(_onDateTapped);
    on<NewHomeTimeTapped>(_onTimeTapped);
    on<NewHomeSubmitTapped>(_onSubmitTapped);
  }

  void _onDateTapped(NewHomeDateTapped event, Emitter<HomeNewTaskStatus> emit) {
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

  void _onTimeTapped(NewHomeTimeTapped event, Emitter<HomeNewTaskStatus> emit) {
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
      NewHomeSubmitTapped event, Emitter<HomeNewTaskStatus> emit) async {
    if (event.missionName == null || event.missionName!.isEmpty) {
      return;
    }

    emit(state.copyWith(
        status: NewHomeStatus.loading,
        missionName: event.missionName,
        description: event.description!.isEmpty ? "" : event.description!));

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
