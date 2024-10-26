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

class FetchTaskList extends TaskListEvent {
  final String? query;
  const FetchTaskList({
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

class ListHomeCheckTask extends TaskListEvent {
  final bool taskStatus;
  final int taskId;

  const ListHomeCheckTask({required this.taskId, required this.taskStatus});

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
