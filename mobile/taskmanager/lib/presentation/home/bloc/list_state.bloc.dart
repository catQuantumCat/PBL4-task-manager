part of "list_home.bloc.dart";

enum HomeStatus {
  initial,
  loading,
  success,
}

class ListHomeState extends Equatable {
  final List<TaskModel> taskList;
  final HomeStatus status;

  const ListHomeState(
      {this.taskList = const [], this.status = HomeStatus.initial});

  ListHomeState copyWith({List<TaskModel>? taskList, HomeStatus? status}) {
    return ListHomeState(
        taskList: taskList ?? this.taskList, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [taskList, status];
}
