part of "home_list.bloc.dart";

class HomeListState extends Equatable {
  final List<TaskModel> taskList;
  final StateStatus status;

  const HomeListState(
      {this.taskList = const [], this.status = StateStatus.initial});

  HomeListState copyWith({List<TaskModel>? taskList, StateStatus? status}) {
    return HomeListState(
        taskList: taskList ?? this.taskList, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [taskList, status];
}
