part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState({
    this.status = StateStatus.initial,
    this.taskList = const [],
    this.errorMessage,
    this.query = ""
  });

  final StateStatus status;
  final List<TaskModel> taskList;
  final String? errorMessage;
  final String query;

  SearchState copyWith({
    StateStatus? status,
    List<TaskModel>? taskList,
    String? errorMessage,
    String? query
  }) {
    return SearchState(
      status: status ?? this.status,
      taskList: taskList ?? this.taskList,
      errorMessage: errorMessage ?? this.errorMessage,
      query: query ?? this.query
    );
  }

  @override
  List<Object?> get props => [status, taskList, errorMessage, query];
}
