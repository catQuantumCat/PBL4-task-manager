part of 'home_detail_task.bloc.dart';

abstract class HomeDetailTaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeTaskDetailClose extends HomeDetailTaskEvent {
  @override
  List<Object?> get props => [];
}

class HomeDetailTaskOpen extends HomeDetailTaskEvent {
  final TaskModel task;

  HomeDetailTaskOpen({required this.task});

  @override
  List<Object?> get props => [task];
}

class HomeDetailTaskChangeMetadata extends HomeDetailTaskEvent {
  final DateTime? date;
  final TimeOfDay? time;
  final bool? status;

  HomeDetailTaskChangeMetadata({this.date, this.time, this.status});

  @override
  List<Object?> get props => [date, time];
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
