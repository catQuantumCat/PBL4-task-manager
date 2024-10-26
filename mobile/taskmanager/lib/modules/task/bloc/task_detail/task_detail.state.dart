// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'task_detail.bloc.dart';

enum DetailHomeStatus { initial, loading, editing, finished, failed }

class TaskDetailState extends Equatable {
  final DetailHomeStatus status;
  final TaskModel? task;

  const TaskDetailState({
    this.status = DetailHomeStatus.initial,
    this.task,
  });

  const TaskDetailState.initial({
    this.status = DetailHomeStatus.initial,
    required this.task,
  });

  const TaskDetailState.loading({
    this.status = DetailHomeStatus.loading,
    this.task,
  });

  @override
  List<Object?> get props => [status, task];

  TaskDetailState copyWith({DetailHomeStatus? status, TaskModel? task}) {
    return TaskDetailState(
      status: status ?? this.status,
      task: task ?? this.task,
    );
  }
}
