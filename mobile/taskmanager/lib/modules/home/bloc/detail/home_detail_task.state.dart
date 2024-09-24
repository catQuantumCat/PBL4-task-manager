// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_detail_task.bloc.dart';

enum DetailHomeStatus { initial, loading, loaded, editing, success, error }

class HomeDetailTaskState extends Equatable {
  final DetailHomeStatus status;
  final TaskModel? task;

  const HomeDetailTaskState(
      {this.status = DetailHomeStatus.initial, required this.task});

  const HomeDetailTaskState.initial(
      {this.status = DetailHomeStatus.initial, this.task});

  const HomeDetailTaskState.loaded(
      {this.status = DetailHomeStatus.loaded, required this.task});

  @override
  List<Object?> get props => [status, task];

  HomeDetailTaskState copyWith({
    DetailHomeStatus? status,
    TaskModel? task,
  }) {
    return HomeDetailTaskState(
      status: status ?? this.status,
      task: task ?? this.task,
    );
  }
}
