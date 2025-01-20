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
    on<TapCheckboxOneTask>(_tapCheckBox);
    on<ForceReloadTask>(_syncFromRemote);
    on<TapOneTask>(_tapOneTask);
    on<UndoLatestTask>(_undoComplete);
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
      _taskRepository.getTaskStream(),
      onData: (newList) {
        final recentlyViewedTasksList = newList
            .where((task) =>
                state.recentlyViewedTasks.any((recent) => recent.id == task.id))
            .toList();

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

  void _tapCheckBox(
      TapCheckboxOneTask event, Emitter<TaskListState> emit) async {
    _editTask(taskId: event.taskId, status: event.taskStatus, emit: emit);
  }

  void _undoComplete(UndoLatestTask event, Emitter<TaskListState> emit) async {
    final recentCompletedTask = state.recentlyCompletedTask;
    if (recentCompletedTask == null) {
      return;
    }
    _editTask(taskId: recentCompletedTask.id, status: false, emit: emit);
  }

  Future<void> _editTask(
      {required int taskId,
      required bool status,
      required Emitter<TaskListState> emit}) async {
    final taskWithIndex = await _taskRepository.getTaskById(taskId);
    if (taskWithIndex == null) {
      emit(state.copyWith(status: StateStatus.failed));
      return;
    }

    try {
      _taskRepository.editTask(
          taskWithIndex.toResponse(status: status), taskId);
      emit(state.copyWith(
          status: StateStatus.success,
          recentlyCompletedTask: status == true ? taskWithIndex : null));
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
