part of 'home_detail_task.bloc.dart';

abstract class HomeDetailTaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeTaskDetailClose extends HomeDetailTaskEvent {}

class HomeDetailTaskOpen extends HomeDetailTaskEvent {
  final TaskModel task;

  HomeDetailTaskOpen({required this.task});

  @override
  List<Object?> get props => [task];
}

class HomeDetailTaskChangeDateTime extends HomeDetailTaskEvent {
  final DateTime? date;
  final TimeOfDay? time;

  HomeDetailTaskChangeDateTime({this.date, this.time});

  @override
  List<Object?> get props => [date, time];
}

class HomeDetailTaskCompleteTask extends HomeDetailTaskEvent {
  final bool? status;

  HomeDetailTaskCompleteTask({required this.status});

  @override
  List<Object?> get props => [status];
}

class HomeDetailTaskEdit extends HomeDetailTaskEvent {
  @override
  List<Object?> get props => [];
}

class HomeDetailTaskCancelEdit extends HomeDetailTaskEvent {
  @override
  List<Object?> get props => [];
}

class HomeDetailTaskSaveEdit extends HomeDetailTaskEvent {
  final String? taskName;
  final String? taskDescription;

  HomeDetailTaskSaveEdit(
      {required this.taskName, required this.taskDescription});

  @override
  List<Object?> get props => [taskName, taskDescription];
}

class HomeDetailTaskDelete extends HomeDetailTaskEvent {
  @override
  List<Object?> get props => [];
}
