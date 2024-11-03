// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState(
      {this.status = StateStatus.initial,
      this.overdueList = const [],
      this.todayList = const [],
      this.errorMessage});

  final StateStatus status;
  final List<TaskModel> overdueList;
  final List<TaskModel> todayList;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage, overdueList, todayList];

  HomeState copyWith({
    StateStatus? status,
    List<TaskModel>? overdueList,
    List<TaskModel>? todayList,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      overdueList: overdueList ?? this.overdueList,
      todayList: todayList ?? this.todayList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
