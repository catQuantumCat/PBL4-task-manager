part of "task_list.bloc.dart";

abstract class TaskListEvent extends Equatable {
  const TaskListEvent();
  @override
  List<Object?> get props => [];
}

class ForceReloadTask extends TaskListEvent {
  const ForceReloadTask();

  @override
  List<Object?> get props => [];
}

class InitTaskList extends TaskListEvent {
  final String? query;
  const InitTaskList({
    this.query,
  });

  @override
  List<Object?> get props => [query];
}

class RemoveOneTask extends TaskListEvent {
  final int taskToRemoveIndex;

  const RemoveOneTask({required this.taskToRemoveIndex});
  @override
  List<Object?> get props => [taskToRemoveIndex];
}

class TapCheckboxOneTask extends TaskListEvent {
  final bool taskStatus;
  final int taskId;

  const TapCheckboxOneTask({required this.taskId, required this.taskStatus});

  @override
  List<Object?> get props => [taskId];
}

class SearchTasks extends TaskListEvent {
  final String query;
  const SearchTasks({
    required this.query,
  });

  @override
  List<Object?> get props => [query];
}

class TapOneTask extends TaskListEvent {
  final TaskModel task;

  const TapOneTask({required this.task});

  @override
  List<Object?> get props => [task];
}

class UndoLatestTask extends TaskListEvent {
  const UndoLatestTask();
}
