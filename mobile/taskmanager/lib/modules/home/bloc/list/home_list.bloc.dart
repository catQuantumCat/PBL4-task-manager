import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:taskmanager/data/datasources/task/remote/task_remote.datasource.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/data/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_list.state.dart';
part 'home_list.event.dart';

class HomeListBloc extends Bloc<HomeListEvent, HomeListState> {
  HomeListBloc() : super(const HomeListState()) {
    on<FetchTaskList>(_fetchList);
    on<RemoveOneTask>(_removeTask);
    on<ListHomeCheckTask>(_editTask);
  }

  final repository = TaskRepository(dataSource: TaskRemoteDataSource());

  void _fetchList(FetchTaskList event, Emitter<HomeListState> emit) async {
    emit(state.copyWith(status: HomeListStatus.loading));

    try {
      final taskList = await repository.getTaskList();
      emit(state.copyWith(status: HomeListStatus.success, taskList: taskList));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: HomeListStatus.failed));
    }
  }

  void _removeTask(RemoveOneTask event, Emitter<HomeListState> emit) async {
    try {
      await repository.deleteTask(event.taskToRemoveIndex);
      add(FetchTaskList());
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: HomeListStatus.failed));
    }
  }

  void _editTask(ListHomeCheckTask event, Emitter<HomeListState> emit) async {
    final TaskModel task = state.taskList.firstWhere((task) {
      return task.id == event.taskId;
    });

    final data = task.toResponse(status: event.taskStatus);

    try {
      repository.editTask(data, event.taskId);
      emit(state.copyWith(status: HomeListStatus.success));
    } catch (e) {
      emit(state.copyWith(status: HomeListStatus.failed));
    }
  }
}
