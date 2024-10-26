part of 'task_detail.bloc.dart';

abstract class TaskDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeTaskDetailClose extends TaskDetailEvent {}

class HomeDetailTaskOpen extends TaskDetailEvent {
  final TaskModel task;

  HomeDetailTaskOpen({required this.task});

  @override
  List<Object?> get props => [task];
}

class HomeDetailTaskChangeDateTime extends TaskDetailEvent {
  final DateTime? date;
  final TimeOfDay? time;

  HomeDetailTaskChangeDateTime({this.date, this.time});

  @override
  List<Object?> get props => [date, time];
}

class HomeDetailTaskCompleteTask extends TaskDetailEvent {
  final bool? status;

  HomeDetailTaskCompleteTask({required this.status});

  @override
  List<Object?> get props => [status];
}

class HomeDetailTaskEdit extends TaskDetailEvent {
  @override
  List<Object?> get props => [];
}

class HomeDetailTaskCancelEdit extends TaskDetailEvent {
  @override
  List<Object?> get props => [];
}

class HomeDetailTaskSaveEdit extends TaskDetailEvent {
  final String? taskName;
  final String? taskDescription;

  HomeDetailTaskSaveEdit(
      {required this.taskName, required this.taskDescription});

  @override
  List<Object?> get props => [taskName, taskDescription];
}

class HomeDetailTaskDelete extends TaskDetailEvent {
  @override
  List<Object?> get props => [];
}
