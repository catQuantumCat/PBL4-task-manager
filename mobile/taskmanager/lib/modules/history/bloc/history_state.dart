// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'history_bloc.dart';

class HistoryState extends Equatable {
  const HistoryState(
      {required this.status, required this.completedTasks, this.errorMessage});

  final StateStatus status;
  final List<TaskModel> completedTasks;
  final String? errorMessage;

  const HistoryState.initial({
    this.status = StateStatus.initial,
    this.completedTasks = const [],
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, completedTasks, errorMessage];

  HistoryState copyWith({
    StateStatus? status,
    List<TaskModel>? completedTasks,
    String? errorMessage,
  }) {
    return HistoryState(
      status: status ?? this.status,
      completedTasks: completedTasks ?? this.completedTasks,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
