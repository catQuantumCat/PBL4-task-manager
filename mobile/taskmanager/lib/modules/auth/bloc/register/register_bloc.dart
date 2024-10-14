import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/config/router/user_local.datasource.dart';
import 'package:taskmanager/data/datasources/remote/user_remote.datasource.dart';
import 'package:taskmanager/data/repositories/user.repository.dart';
import 'package:taskmanager/modules/auth/bloc/auth/auth_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required AuthBloc authBloc})
      : _authBloc = authBloc,
        super(const RegisterState.initial()) {
    on<SubmitRegisterTapped>(_onRegisterTapped);
  }

  final AuthBloc _authBloc;

  final repo = UserRepository(
      remoteSource: UserRemoteDatasource(), localSource: UserLocalDatasource());

  Future<void> _onRegisterTapped(
      SubmitRegisterTapped event, Emitter<RegisterState> emit) async {
    emit(const RegisterState.loading());

    try {
      final token = await repo.submitRegister(
          email: event.email,
          username: event.username,
          password: event.password);

      _authBloc.add(AuthSetToken(tokenString: token));

      emit(const RegisterState.success());
    } catch (e) {
      emit(RegisterState.failed(errorString: e.toString()));
    }
  }
}
