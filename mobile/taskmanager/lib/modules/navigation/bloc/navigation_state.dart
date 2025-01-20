part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  const NavigationState({this.index = 0});

  final int index;

  @override
  List<Object> get props => [index];

  NavigationState copyWith({int? index}) {
    return NavigationState(index: index ?? this.index);
  }
}
