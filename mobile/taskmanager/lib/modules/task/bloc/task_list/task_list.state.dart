part of "task_list.bloc.dart";

class TaskListState extends Equatable {
  final List<TaskModel> recentlyViewedTasks;
  final StateStatus status;

  const TaskListState(
      {this.status = StateStatus.initial, this.recentlyViewedTasks = const []});

  TaskListState copyWith(
      {StateStatus? status, List<TaskModel>? recentlyViewedTasks}) {
    return TaskListState(
        status: status ?? this.status,
        recentlyViewedTasks: recentlyViewedTasks ?? this.recentlyViewedTasks);
  }

  @override
  List<Object?> get props => [status, recentlyViewedTasks];
}
