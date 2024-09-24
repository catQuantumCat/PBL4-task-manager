part of "home_list.bloc.dart";

enum HomeListStatus { initial, loading, success, failed }

class HomeListState extends Equatable {
  final List<TaskModel> taskList;
  final HomeListStatus status;

  const HomeListState(
      {this.taskList = const [], this.status = HomeListStatus.initial});

  HomeListState copyWith({List<TaskModel>? taskList, HomeListStatus? status}) {
    return HomeListState(
        taskList: taskList ?? this.taskList, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [taskList, status];
}
