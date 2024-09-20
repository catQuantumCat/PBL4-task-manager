import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/data/task_model.dart';
import 'package:taskmanager/common/api_constant.dart';
part 'detail_home.event.dart';
part 'detail_home.state.dart';

class DetailHomeBloc extends Bloc<DetailHomeEvent, DetailHomeState> {
  DetailHomeBloc() : super(const DetailHomeState.initial()) {
    on<DetailHomeClose>(_onCloseDown);
    on<DetailHomeOpen>(_onOpen);
    on<DetailHomeEditTask>(_onEditTask);
    on<DetailHomeOpenEdit>(_onOpenEdit);
    on<DetailHomeCancelEdit>(_onCancelEdit);
    on<DetailHomeSaveEdit>(_onSaveEdit);
  }

  void _onCloseDown(DetailHomeClose event, Emitter<DetailHomeState> emit) {
    //TODO: save progress
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

    final data = state.task!.copyWith(deadTime: date, status: event.status);

    final dio = Dio();
    emit(state.copyWith(status: DetailHomeStatus.loading));
    try {
      await dio.put("${ApiConstant.api_const}${state.task!.id}",
          data: data.toResponse().toJson());
    } catch (e) {
      print(e);
    }

    emit(DetailHomeState.loaded(task: data));
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

    final TaskModel data = state.task!
        .copyWith(name: event.taskName, description: event.taskDescription);

    emit(state.copyWith(status: DetailHomeStatus.loading));
    final dio = Dio();

    try {
      await dio.put("${ApiConstant.api_const}${state.task!.id}",
          data: data.toResponse().toJson());
    } catch (e) {
      print(e);
    }

    emit(DetailHomeState.loaded(task: data));
  }
}
