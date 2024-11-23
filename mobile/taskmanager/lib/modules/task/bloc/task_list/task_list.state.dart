part of "task_list.bloc.dart";

class TaskListState extends Equatable {
  final List<TaskModel> recentlyViewedTasks;
  final TaskModel? recentlyCompletedTask;
  final StateStatus status;

  const TaskListState(
      {this.status = StateStatus.initial,
      this.recentlyViewedTasks = const [],
      this.recentlyCompletedTask});

  TaskListState copyWith(
      {StateStatus? status,
      List<TaskModel>? recentlyViewedTasks,
      TaskModel? recentlyCompletedTask}) {
    return TaskListState(
        status: status ?? this.status,
        recentlyViewedTasks: recentlyViewedTasks ?? this.recentlyViewedTasks,
        recentlyCompletedTask:
            recentlyCompletedTask ?? this.recentlyCompletedTask);
  }

  @override
  List<Object?> get props =>
      [status, recentlyViewedTasks, recentlyCompletedTask];
}
