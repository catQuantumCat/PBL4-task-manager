import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_list.state.dart';
part 'task_list.event.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  TaskListBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(const TaskListState()) {
    taskRepository.init();
    on<InitTaskList>(_initTaskList);
    on<RemoveOneTask>(_removeTask);
    on<ListHomeCheckTask>(_editTask);
    on<ForceReloadTask>(_syncFromRemote);
    on<TapOneTask>(_tapOneTask);
    add(const InitTaskList());
  }

  final TaskRepository _taskRepository;
  @override
  Future<void> close() async {
    await _taskRepository.dispose();
    return super.close();
  }

  void _syncFromRemote(
      ForceReloadTask event, Emitter<TaskListState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));
    try {
      _taskRepository.syncFromRemote();
    } catch (e) {
      emit(state.copyWith(status: StateStatus.failed));
      log(e.toString());
    }
  }

  void _initTaskList(InitTaskList event, Emitter<TaskListState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));

    await emit.forEach<List<TaskModel>>(
      _taskRepository.getTaskList(),
      onData: (newList) {
        final recentlyViewedTasksList = newList
            .where((task) =>
                state.recentlyViewedTasks.any((recent) => recent.id == task.id))
            .toList();

        log(recentlyViewedTasksList.toString(), name: "UPDATED RECENT");

        return state.copyWith(
            status: StateStatus.success,
            recentlyViewedTasks: recentlyViewedTasksList);
      },
      onError: (error, stackTrace) {
        log(error.toString());
        return state.copyWith(status: StateStatus.failed);
      },
    );
  }

  void _removeTask(RemoveOneTask event, Emitter<TaskListState> emit) async {
    try {
      await _taskRepository.deleteTask(event.taskToRemoveIndex);
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: StateStatus.failed));
    }
  }

  void _editTask(ListHomeCheckTask event, Emitter<TaskListState> emit) async {
    final taskWithIndex = await _taskRepository.getTaskById(event.taskId);
    if (taskWithIndex == null) {
      emit(state.copyWith(status: StateStatus.failed));
      return;
    }

    final data = taskWithIndex.toResponse(status: event.taskStatus);

    try {
      _taskRepository.editTask(data, event.taskId);
      emit(state.copyWith(status: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.failed));
    }
  }

  void _tapOneTask(TapOneTask event, Emitter<TaskListState> emit) {
    emit(state.copyWith(status: StateStatus.loading));
    final recentlyViewed = [
      event.task,
      ...state.recentlyViewedTasks.where((task) => task.id != event.task.id)
    ].take(6).toList();

    log(recentlyViewed.toString(), name: "TAP RECENT");
    emit(state.copyWith(
        status: StateStatus.success, recentlyViewedTasks: recentlyViewed));
  }
}
