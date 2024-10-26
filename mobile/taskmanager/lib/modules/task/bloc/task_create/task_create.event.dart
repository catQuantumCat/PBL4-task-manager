part of 'task_create.bloc.dart';

abstract class TaskCreateEvent extends Equatable {
  const TaskCreateEvent();
  @override
  List<Object?> get props => [];
}

class NewHomeDateTapped extends TaskCreateEvent {
  final DateTime? date;

  const NewHomeDateTapped({required this.date});

  @override
  List<Object?> get props => [date];
}

class NewHomeTimeTapped extends TaskCreateEvent {
  final TimeOfDay? time;
  const NewHomeTimeTapped({this.time});
  @override
  List<Object?> get props => [time];
}

class NewHomeSubmitTapped extends TaskCreateEvent {
  final String? missionName;
  final String? description;

  const NewHomeSubmitTapped(
      {required this.missionName, required this.description});

  @override
  List<Object?> get props => [missionName, description];
}
