part of "home_list.bloc.dart";

abstract class HomeListEvent extends Equatable {
  const HomeListEvent();
  @override
  List<Object?> get props => [];
}

class ForceReloadTask extends HomeListEvent {
  const ForceReloadTask();

  @override
  List<Object?> get props => [];
}

class FetchTaskList extends HomeListEvent {
  final String? query;
  const FetchTaskList({
    this.query,
  });

  @override
  List<Object?> get props => [query];
}

class RemoveOneTask extends HomeListEvent {
  final int taskToRemoveIndex;

  const RemoveOneTask({required this.taskToRemoveIndex});
  @override
  List<Object?> get props => [taskToRemoveIndex];
}

class ListHomeCheckTask extends HomeListEvent {
  final bool taskStatus;
  final int taskId;

  const ListHomeCheckTask({required this.taskId, required this.taskStatus});

  @override
  List<Object?> get props => [taskId];
}

class SearchTasks extends HomeListEvent {
  final String query;
  const SearchTasks({
    required this.query,
  });

  @override
  List<Object?> get props => [query];
}
