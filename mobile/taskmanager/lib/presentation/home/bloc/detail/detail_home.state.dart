// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_home.bloc.dart';

enum DetailHomeStatus { initial, loading, loaded, editing, success, error }

class DetailHomeState extends Equatable {
  final DetailHomeStatus status;
  final TaskModel? task;

  const DetailHomeState(
      {this.status = DetailHomeStatus.initial, required this.task});

  const DetailHomeState.initial(
      {this.status = DetailHomeStatus.initial, this.task});

  const DetailHomeState.loaded(
      {this.status = DetailHomeStatus.loaded, required this.task});

  @override
  List<Object?> get props => [status, task];

  DetailHomeState copyWith({
    DetailHomeStatus? status,
    TaskModel? task,
  }) {
    return DetailHomeState(
      status: status ?? this.status,
      task: task ?? this.task,
    );
  }
}
