part of "home_bloc.dart";

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class FetchTaskList extends HomeEvent {}

class RemoveOneTask extends HomeEvent {
  final int taskToRemoveIndex;

  const RemoveOneTask({required this.taskToRemoveIndex});
}
