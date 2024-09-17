part of 'detail_home.bloc.dart';

abstract class DetailHomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailHomeClose extends DetailHomeEvent {
  @override
  List<Object?> get props => [];
}

class DetailHomeOpen extends DetailHomeEvent {
  final TaskModel task;

  DetailHomeOpen({required this.task});

  @override
  List<Object?> get props => [task];
}

class DetailHomeEditTask extends DetailHomeEvent {
  final DateTime? date;
  final TimeOfDay? time;
  final bool? status;

  DetailHomeEditTask({this.date, this.time, this.status});

  @override
  List<Object?> get props => [date, time];
}

class DetailHomeOpenEdit extends DetailHomeEvent {
  @override
  List<Object?> get props => [];
}

class DetailHomeCancelEdit extends DetailHomeEvent {
  @override
  List<Object?> get props => [];
}

class DetailHomeSaveEdit extends DetailHomeEvent {
  final String? taskName;
  final String? taskDescription;

  DetailHomeSaveEdit({required this.taskName, required this.taskDescription});

  @override
  List<Object?> get props => [taskName, taskDescription];
}
