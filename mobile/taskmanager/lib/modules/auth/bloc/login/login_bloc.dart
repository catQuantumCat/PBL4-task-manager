import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager/config/router/user_local.datasource.dart';

import 'package:taskmanager/data/datasources/remote/user_remote.datasource.dart';
import 'package:taskmanager/data/repositories/user.repository.dart';
import 'package:taskmanager/modules/auth/bloc/auth/auth_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthBloc authBloc})
      : _authBloc = authBloc,
        super(const LoginInitial()) {
    on<LoginSubmitTapped>(_onSubmitTapped);
  }

  final AuthBloc _authBloc;
  final repo = UserRepository(
      remoteSource: UserRemoteDatasource(), localSource: UserLocalDatasource());

  Future<void> _onSubmitTapped(
      LoginSubmitTapped event, Emitter<LoginState> emit) async {
    emit(const LoginLoading());

    try {
      final token = await repo.submitLogin(
          userName: event.username, password: event.password);

      _authBloc.add(AuthSetToken(tokenString: token));
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      log(e.toString());
      if (e is DioException && e.response?.statusCode == 401) {
        emit(
          const LoginState.failed(
              errorString: "Incorrect username or password, please try again"),
        );
      } else {
        emit(LoginState.failed(errorString: e.toString()));
      }
    }
  }
}
