import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final TaskRepository _repository;
  HistoryBloc({required TaskRepository repository})
      : _repository = repository,
        super(const HistoryState.initial()) {
    on<HistoryOpen>(_onOpen);
    add(const HistoryOpen());
  }

  void _initialLoad(Emitter emit) {
    state.copyWith(status: StateStatus.loading);
    try {
      final List<TaskModel> completedTasks = _repository
          .getTaskList()
          .where((task) => task.status == true)
          .toList();

      emit(state.copyWith(
          status: StateStatus.success, completedTasks: completedTasks));
    } catch (e) {
      emit(state.copyWith(
          status: StateStatus.failed, errorMessage: e.toString()));
    }
  }

  Future<void> _onOpen(HistoryOpen event, Emitter emit) async {
    _initialLoad(emit);

    final Stream<List<TaskModel>> stream = _repository.getTaskStream();

    await emit.forEach(stream, onData: (taskList) {
      state.copyWith(status: StateStatus.loading);
      return state.copyWith(
          status: StateStatus.success,
          completedTasks:
              taskList.where((task) => task.status == true).toList());
    }, onError: (error, trace) {
      return state.copyWith(
          status: StateStatus.failed, errorMessage: error.toString());
    });
  }
}
