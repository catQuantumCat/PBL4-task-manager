import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/data/model/task_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TaskRepository _taskRepository;

  SearchBloc({
    required TaskRepository taskRepository,
  })  : _taskRepository = taskRepository,
        super(const SearchState(status: StateStatus.initial)) {
    on<SearchOpen>(_onOpenSearch);
    on<SearchEnterQuery>(_onEnterQuery);
    on<SearchCancel>(_onCancelSearch);
    on<SearchReturnTapped>(_onReturnTapped);
    on<SearchClearRecent>(_onClearRecentSearch);
  }

  Future<void> _onOpenSearch(
      SearchOpen event, Emitter<SearchState> emit) async {
    await emit.forEach<List<TaskModel>>(
      _taskRepository.getTaskStream(),
      onData: (newList) {
        final filteredList =
            newList.where((task) => task.name.contains(state.query)).toList();

        return state.copyWith(taskList: filteredList);
      },
      onError: (error, stackTrace) {
        log(error.toString());
        return state.copyWith(
            status: StateStatus.failed,
            errorMessage: "Search cannot be initialized!");
      },
    );
  }

  Future<void> _onEnterQuery(
      SearchEnterQuery event, Emitter<SearchState> emit) async {
    final taskList = _taskRepository.searchTask(event.query);

    if (taskList.isEmpty) {
      emit(state.copyWith(
          status: StateStatus.failed,
          errorMessage: "No result for \"${event.query}\"",
          query: event.query));
      return;
    }
    emit(
      state.copyWith(
          status: StateStatus.success,
          taskList: _taskRepository.searchTask(event.query),
          query: event.query),
    );
  }

  void _onCancelSearch(SearchCancel event, Emitter<SearchState> emit) {
    emit(state.copyWith(status: StateStatus.initial, query: ""));
  }

  void _onReturnTapped(SearchReturnTapped event, Emitter<SearchState> emit) {
    emit(state.copyWith(
        recentlySearched:
            [event.query, ...state.recentlySearched].take(6).toList()));
  }

  void _onClearRecentSearch(
      SearchClearRecent event, Emitter<SearchState> emit) {
    emit(state.copyWith(recentlySearched: []));
  }
}
