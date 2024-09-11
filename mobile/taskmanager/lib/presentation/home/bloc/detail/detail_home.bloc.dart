import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/data/task_model.dart';
part 'detail_home.event.dart';
part 'detail_home.state.dart';

class DetailHomeBloc extends Bloc<DetailHomeEvent, DetailHomeState> {
  DetailHomeBloc() : super(const DetailHomeState()) {
    on<DetailHomeClose>(_onCloseDown);
  }

  void _onCloseDown(DetailHomeClose event, Emitter<DetailHomeState> emit) {
    //TODO: save progress
    print("Close down received");
  }
}
