part of "task_list.bloc.dart";

class TaskListState extends Equatable {
  final List<TaskModel> taskList;
  final List<TaskModel> recentlyViewedTasks;
  final StateStatus status;

  const TaskListState(
      {this.taskList = const [],
      this.status = StateStatus.initial,
      this.recentlyViewedTasks = const []});

  TaskListState copyWith(
      {List<TaskModel>? taskList,
      StateStatus? status,
      List<TaskModel>? recentlyViewedTasks}) {
    return TaskListState(
        taskList: taskList ?? this.taskList,
        status: status ?? this.status,
        recentlyViewedTasks: recentlyViewedTasks ?? this.recentlyViewedTasks);
  }

  @override
  List<Object?> get props => [taskList, status, recentlyViewedTasks];
}
