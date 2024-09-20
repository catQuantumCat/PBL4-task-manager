import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:taskmanager/common/api_constant.dart';
import 'package:taskmanager/data/datasources/task/remote/task_remote.datasource.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/data/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dio/dio.dart';

part 'list_home.state.dart';
part 'list_home.event.dart';

class ListHomeBloc extends Bloc<ListHomeEvent, ListHomeState> {
  ListHomeBloc() : super(const ListHomeState()) {
    on<FetchTaskList>(_fetchList);
    on<RemoveOneTask>(_removeTask);
    on<ListHomeCheckTask>(_editTask);
  }

  final repository = TaskRepository(dataSource: TaskRemoteDataSource());

  void _fetchList(FetchTaskList event, Emitter<ListHomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      final taskList = await repository.getTaskList();
      emit(state.copyWith(status: HomeStatus.success, taskList: taskList));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: HomeStatus.failed));
    }
  }

  void _removeTask(RemoveOneTask event, Emitter<ListHomeState> emit) async {
    final dio = Dio();
    try {
      await dio.delete("${ApiConstant.api_const}${event.taskToRemoveIndex}");
    } catch (e) {
      print(e);
    }
    add(FetchTaskList());
  }

  void _editTask(ListHomeCheckTask event, Emitter<ListHomeState> emit) async {
    final TaskModel task = state.taskList.firstWhere((task) {
      return task.id == event.taskId;
    });

    final data = task.toResponse(status: event.taskStatus);

    try {
      repository.editTask(data, event.taskId);
      emit(state.copyWith(status: HomeStatus.success));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failed));
    }
  }
}
