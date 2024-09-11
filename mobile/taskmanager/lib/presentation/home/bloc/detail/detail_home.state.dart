part of 'detail_home.bloc.dart';

enum DetailHomeStatus { initial, success, error }

class DetailHomeState extends Equatable {
  final DetailHomeStatus status;
  final TaskModel? task;

  const DetailHomeState({this.status = DetailHomeStatus.initial, this.task});

  @override
  List<Object?> get props => [status, task];
}
