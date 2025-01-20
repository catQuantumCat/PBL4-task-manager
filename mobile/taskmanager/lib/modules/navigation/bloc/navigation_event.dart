part of 'navigation_bloc.dart';

sealed class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigationItemTapped extends NavigationEvent {
  final int newIndex;

  const NavigationItemTapped({required this.newIndex});

  @override
  List<Object> get props => [newIndex];
}
