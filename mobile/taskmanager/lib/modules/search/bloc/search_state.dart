part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState({required this.status, this.errorMessage, this.taskList});

  final StateStatus status;
  final List<TaskModel>? taskList;
  final String? errorMessage;

  const SearchState.success({
    this.status = StateStatus.success,
    this.errorMessage,
    required this.taskList,
  });

  const SearchState.initial({
    this.status = StateStatus.initial,
    this.errorMessage,
    this.taskList,
  });

  const SearchState.failed(
      {this.status = StateStatus.failed,
      required this.errorMessage,
      this.taskList});

  const SearchState.loading(
      {this.status = StateStatus.loading, this.errorMessage, this.taskList});

  @override
  List<Object?> get props => [status, taskList, errorMessage];
}
