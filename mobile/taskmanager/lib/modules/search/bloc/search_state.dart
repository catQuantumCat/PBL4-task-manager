part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState(
      {this.status = StateStatus.initial,
      this.taskList = const [],
      this.recentlySearched = const [],
      this.errorMessage,
      this.query = ""});

  final StateStatus status;
  final List<TaskModel> taskList;
  final List<String> recentlySearched;
  final String? errorMessage;
  final String query;

  SearchState copyWith({
    StateStatus? status,
    List<TaskModel>? taskList,
    List<String>? recentlySearched,
    String? errorMessage,
    String? query,
  }) {
    return SearchState(
      status: status ?? this.status,
      taskList: taskList ?? this.taskList,
      recentlySearched: recentlySearched ?? this.recentlySearched,
      errorMessage: errorMessage ?? this.errorMessage,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props =>
      [status, taskList, errorMessage, query, recentlySearched];
}
