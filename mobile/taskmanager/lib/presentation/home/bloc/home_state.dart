part of "home_bloc.dart";

enum HomeStatus {
  initial,
  loading,
  success,
}

class HomeState extends Equatable {
  final List<TaskModel> taskList;
  final HomeStatus status;

  const HomeState({this.taskList = const [], this.status = HomeStatus.initial});

  HomeState copyWith({List<TaskModel>? taskList, HomeStatus? status}) {
    return HomeState(
        taskList: taskList ?? this.taskList, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [taskList, status];
}
