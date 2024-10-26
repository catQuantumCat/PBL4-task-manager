part of "task_list.bloc.dart";

class TaskListState extends Equatable {
  final List<TaskModel> taskList;
  final StateStatus status;

  const TaskListState(
      {this.taskList = const [], this.status = StateStatus.initial});

  TaskListState copyWith({List<TaskModel>? taskList, StateStatus? status}) {
    return TaskListState(
        taskList: taskList ?? this.taskList, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [taskList, status];
}
