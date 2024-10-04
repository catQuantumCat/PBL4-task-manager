// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_detail_task.bloc.dart';

enum DetailHomeStatus { initial, loading, editing, finished, failed }

class HomeDetailTaskState extends Equatable {
  final DetailHomeStatus status;
  final TaskModel? task;
  final bool isEdited;

  const HomeDetailTaskState({
    this.status = DetailHomeStatus.initial,
    this.task,
    required this.isEdited,
  });

  const HomeDetailTaskState.initial({
    this.status = DetailHomeStatus.initial,
    this.task,
    this.isEdited = false,
  });

  @override
  List<Object?> get props => [status, task, isEdited];

  HomeDetailTaskState copyWith(
      {DetailHomeStatus? status, TaskModel? task, bool? isEdited}) {
    return HomeDetailTaskState(
        status: status ?? this.status,
        task: task ?? this.task,
        isEdited: isEdited ?? this.isEdited);
  }
}
