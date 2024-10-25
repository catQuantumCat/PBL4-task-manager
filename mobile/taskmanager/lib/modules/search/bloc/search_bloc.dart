import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/data/task_model.dart';
import 'package:taskmanager/modules/home/bloc/list/home_list.bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TaskRepository _taskRepository;
  final HomeListBloc _homeListBloc;

  SearchBloc(
      {required TaskRepository taskRepository,
      required HomeListBloc homeListBloc})
      : _taskRepository = taskRepository,
        _homeListBloc = homeListBloc,
        super(const SearchState.initial()) {
    on<SearchOpen>(_onOpenSearch);
    on<SearchEnterQuery>(_onEnterQuery);
    on<SearchCancel>(_onCancelSearch);
  }

  void _onOpenSearch(SearchOpen event, Emitter<SearchState> emit) {
    emit(const SearchState.initial());
  }

  Future<void> _onEnterQuery(

      // _homeListBloc.add(FetchTaskList(query: event.query));

      //   emit(SearchState.success(taskList: _homeListBloc.state.taskList));

      SearchEnterQuery event,
      Emitter<SearchState> emit) async {
    // emit(const SearchState.loading());

    emit(const SearchState.failed(errorMessage: "Not implemented"));

    // try {
    //   final taskList =
    //       await _taskRepository.getTaskList(queryName: event.query);

    //   emit(SearchState.success(taskList: taskList));
    // } catch (e) {}
  }

  void _onCancelSearch(SearchCancel event, Emitter<SearchState> emit) {
    emit(const SearchState.initial());
  }
}
