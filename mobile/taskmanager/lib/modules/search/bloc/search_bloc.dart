import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/data/task_model.dart';
import 'package:taskmanager/modules/task/bloc/task_list/task_list.bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TaskRepository _taskRepository;

  SearchBloc(
      {required TaskRepository taskRepository,
      required TaskListBloc homeListBloc})
      : _taskRepository = taskRepository,
        super(const SearchState(status: StateStatus.initial)) {
    on<SearchOpen>(_onOpenSearch);
    on<SearchEnterQuery>(_onEnterQuery);
    on<SearchCancel>(_onCancelSearch);
  }

  Future<void> _onOpenSearch(
      SearchOpen event, Emitter<SearchState> emit) async {
    await emit.forEach<List<TaskModel>>(
      _taskRepository.getTaskList(),
      onData: (newList) {
        final filteredList =
            newList.where((task) => task.name.contains(state.query)).toList();

        return state.copyWith(
            status: StateStatus.success, taskList: filteredList);
      },
      onError: (error, stackTrace) {
        log(error.toString());
        return state.copyWith(status: StateStatus.failed);
      },
    );
  }

  Future<void> _onEnterQuery(
      SearchEnterQuery event, Emitter<SearchState> emit) async {
    
    emit(
      state.copyWith(
          status: StateStatus.success,
          taskList: _taskRepository.searchTask(event.query),
          query: event.query),
    );
  }

  void _onCancelSearch(SearchCancel event, Emitter<SearchState> emit) {
    emit(state.copyWith(status: StateStatus.initial));
  }
}
