part of 'new_home.bloc.dart';

abstract class NewHomeEvent extends Equatable {
  const NewHomeEvent();
  @override
  List<Object?> get props => [];
}

class NewHomeDateTapped extends NewHomeEvent {
  final DateTime? date;

  const NewHomeDateTapped({required this.date});

  @override
  List<Object?> get props => [date];
}

class NewHomeTimeTapped extends NewHomeEvent {
  final TimeOfDay? time;
  const NewHomeTimeTapped({this.time});
  @override
  List<Object?> get props => [time];
}

class NewHomeSubmitTapped extends NewHomeEvent {
  final String? missionName;
  final String? description;

  const NewHomeSubmitTapped(
      {required this.missionName, required this.description});

  @override
  List<Object?> get props => [missionName, description];
}
