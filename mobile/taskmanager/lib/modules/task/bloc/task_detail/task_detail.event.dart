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

class DetailPropertiesChange extends TaskDetailEvent {
  final DateTime? date;
  final TimeOfDay? time;
  final int? priority;

  DetailPropertiesChange({this.date, this.time, this.priority});

  @override
  List<Object?> get props => [date, time, priority];
}

class HomeDetailTaskCompleteTask extends TaskDetailEvent {
  final bool? status;

  HomeDetailTaskCompleteTask({required this.status});

  @override
  List<Object?> get props => [status];
}

class HomeDetailTaskEdit extends TaskDetailEvent {
  final bool focusOnTitle;

  HomeDetailTaskEdit({required this.focusOnTitle});
  @override
  List<Object?> get props => [focusOnTitle];
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
