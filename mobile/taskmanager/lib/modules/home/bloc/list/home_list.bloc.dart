import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/data/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_list.state.dart';
part 'home_list.event.dart';

class HomeListBloc extends Bloc<HomeListEvent, HomeListState> {
  HomeListBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(const HomeListState()) {
    on<FetchTaskList>(_fetchList);
    on<RemoveOneTask>(_removeTask);
    on<ListHomeCheckTask>(_editTask);
    on<ForceReloadTask>(_syncFromRemote);
    // _listenToStream();
  }

  final TaskRepository _taskRepository;

  void _syncFromRemote(
      ForceReloadTask event, Emitter<HomeListState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));
    try {
      _taskRepository.syncFromRemote();
    } catch (e) {
      log(e.toString());
    }
  }

  void _fetchList(FetchTaskList event, Emitter<HomeListState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));

    await emit.forEach<List<TaskModel>>(
      _taskRepository.getTaskList(),
      onData: (newList) {
        log("NEW DATA INCOMING");
        log("LATEST DATA: ${newList.last.toString()}");
        return state.copyWith(
          status: StateStatus.success,
          taskList: [...newList],
        );
      },
      onError: (error, stackTrace) {
        log(error.toString());
        return state.copyWith(status: StateStatus.failed);
      },
    );
  }

  void _removeTask(RemoveOneTask event, Emitter<HomeListState> emit) async {
    try {
      await _taskRepository.deleteTask(event.taskToRemoveIndex);
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: StateStatus.failed));
    }
  }

  void _editTask(ListHomeCheckTask event, Emitter<HomeListState> emit) async {
    // emit(state.copyWith(status: StateStatus.loading));
    final TaskModel task = state.taskList.firstWhere((task) {
      return task.id == event.taskId;
    });

    final data = task.toResponse(status: event.taskStatus);

    try {
      _taskRepository.editTask(data, event.taskId);
      // emit(state.copyWith(status: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.failed));
    }
  }
}
