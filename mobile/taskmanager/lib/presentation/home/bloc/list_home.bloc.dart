import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:taskmanager/data/dummy_data.dart';
import 'package:taskmanager/data/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dio/dio.dart';

part 'list_state.bloc.dart';
part 'list_home.event.dart';

class ListHomeBloc extends Bloc<ListHomeEvent, ListHomeState> {
  ListHomeBloc() : super(const ListHomeState()) {
    on<FetchTaskList>(_fetchList);
    on<RemoveOneTask>(_removeTask);
  }

  void _fetchList(FetchTaskList event, Emitter<ListHomeState> emit) async {
    final dio = Dio(BaseOptions(
      responseType: ResponseType.plain,
    ));
    emit(state.copyWith(status: HomeStatus.loading));

    final List<TaskModel> taskList = [];

    try {
      final res = await dio.get("http://10.0.2.2:5245/backend/mission");

      final data = jsonDecode(res.data.toString());

      for (var i in data) {
        taskList.add(TaskModel.fromJson(i));
      }
    } catch (e) {
      print('Error occurred while fetching task list: $e');
    }

    emit(state.copyWith(status: HomeStatus.success, taskList: taskList));
  }

  void _removeTask(RemoveOneTask event, Emitter<ListHomeState> emit) async {
    dummyData.removeAt(event.taskToRemoveIndex);
  }
}
