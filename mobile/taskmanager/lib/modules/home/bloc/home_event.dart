part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeOpen extends HomeEvent {
  const HomeOpen();
}

class HomeRefresh extends HomeEvent {
  const HomeRefresh();
}
