import 'package:equatable/equatable.dart';
import 'package:taskmanager/data/dummy_data.dart';
import 'package:taskmanager/data/task_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<FetchTaskList>(_fetchList);
    on<RemoveOneTask>(_removeTask);
  }

  void _fetchList(FetchTaskList event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    // await Future.delayed(Duration(seconds: 3));
    emit(state.copyWith(status: HomeStatus.success, taskList: dummyData));
  }

  void _removeTask(RemoveOneTask event, Emitter<HomeState> emit) async {
    dummyData.removeAt(event.taskToRemoveIndex);
  }
}
