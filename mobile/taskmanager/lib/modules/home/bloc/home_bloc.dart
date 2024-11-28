import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/data/model/task_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(const HomeState()) {
    on<HomeOpen>(_onOpen);
    on<HomeRefresh>(_onRefresh);
    add(const HomeOpen());
  }
  final TaskRepository _taskRepository;

  Future<void> _onOpen(HomeOpen event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));
    final DateTime today = DateTime.now();
    await emit.forEach<List<TaskModel>>(
      _taskRepository.getTaskStream(),
      onData: (newList) {
        return state.copyWith(
            status: StateStatus.success,
            todayList: newList
                .where((task) => task.deadTime.isSameDate(today))
                .toList(),
            overdueList: newList
                .where((task) => task.deadTime.isPast(of: today))
                .toList());
      },
      onError: (error, stackTrace) {
        return state.copyWith(
          status: StateStatus.failed,
          errorMessage: error.toString(),
        );
      },
    );
  }

  void _onRefresh(HomeEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(status: StateStatus.loading));
    try {
      _taskRepository.syncFromRemote();
      add(const HomeOpen());
    } catch (e) {
      emit(state.copyWith(
          status: StateStatus.failed, errorMessage: e.toString()));
    }
  }
}
