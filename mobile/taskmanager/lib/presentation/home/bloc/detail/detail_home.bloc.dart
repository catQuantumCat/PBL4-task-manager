import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/data/dtos/task.dto.dart';
import 'package:taskmanager/data/task_model.dart';
part 'detail_home.event.dart';
part 'detail_home.state.dart';

class DetailHomeBloc extends Bloc<DetailHomeEvent, DetailHomeState> {
  DetailHomeBloc() : super(const DetailHomeState.initial()) {
    on<DetailHomeClose>(_onCloseDown);
    on<DetailHomeOpen>(_onOpen);
    on<DetailHomeEditTask>(_onEditTask);
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
      await dio.put("http://10.0.2.2:5245/backend/mission/${state.task!.id}",
          data: data.toResponse().toJson());
    } catch (e) {
      print(e);
    }

    emit(DetailHomeState.loaded(task: data));
  }
}
