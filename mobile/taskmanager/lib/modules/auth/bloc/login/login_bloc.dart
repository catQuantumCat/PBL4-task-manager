import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:taskmanager/common/constants/hive_constant.dart';
import 'package:taskmanager/data/datasources/local/user_local.datasource.dart';

import 'package:taskmanager/data/datasources/remote/user_remote.datasource.dart';
import 'package:taskmanager/data/repositories/user.repository.dart';
import 'package:taskmanager/modules/auth/bloc/auth/auth_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(
      {required AuthBloc authBloc, required UserRepository userRepository})
      : _authBloc = authBloc,
        _userRepository = userRepository,
        super(const LoginInitial()) {
    on<LoginSubmitTapped>(_onSubmitTapped);
  }

  final AuthBloc _authBloc;
  final UserRepository _userRepository;

  Future<void> _onSubmitTapped(
      LoginSubmitTapped event, Emitter<LoginState> emit) async {
    emit(const LoginLoading());

    try {
      final token = await _userRepository.submitLogin(
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
