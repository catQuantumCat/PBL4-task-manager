part of 'home_new_task.bloc.dart';

abstract class HomeNewTaskEvent extends Equatable {
  const HomeNewTaskEvent();
  @override
  List<Object?> get props => [];
}

class NewHomeDateTapped extends HomeNewTaskEvent {
  final DateTime? date;

  const NewHomeDateTapped({required this.date});

  @override
  List<Object?> get props => [date];
}

class NewHomeTimeTapped extends HomeNewTaskEvent {
  final TimeOfDay? time;
  const NewHomeTimeTapped({this.time});
  @override
  List<Object?> get props => [time];
}

class NewHomeSubmitTapped extends HomeNewTaskEvent {
  final String? missionName;
  final String? description;

  const NewHomeSubmitTapped(
      {required this.missionName, required this.description});

  @override
  List<Object?> get props => [missionName, description];
}
