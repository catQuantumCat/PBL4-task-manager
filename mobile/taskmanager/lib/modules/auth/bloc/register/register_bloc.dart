import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/data/datasources/remote/user_remote.datasource.dart';
import 'package:taskmanager/data/repositories/user.repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState.initial()) {
    on<SubmitRegisterTapped>(_onRegisterTapped);
  }

  final repo = UserRepository(datasource: UserRemoteDatasource());

  Future<void> _onRegisterTapped(
      SubmitRegisterTapped event, Emitter<RegisterState> emit) async {
    emit(const RegisterState.loading());
    await Future.delayed(const Duration(seconds: 3));
    try {
      await repo.submitRegister(
          email: event.email,
          username: event.username,
          password: event.password);

      emit(const RegisterState.success());
    } catch (e) {
      emit(RegisterState.failed(errorString: e.toString()));
    }
  }
}
