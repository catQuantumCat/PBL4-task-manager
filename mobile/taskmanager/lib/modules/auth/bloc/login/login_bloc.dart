import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:taskmanager/data/datasources/remote/user_remote.datasource.dart';
import 'package:taskmanager/data/repositories/user.repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial()) {
    on<LoginSubmitTapped>(_onSubmitTapped);
  }

  final repo = UserRepository(datasource: UserRemoteDatasource());

  Future<void> _onSubmitTapped(
      LoginSubmitTapped event, Emitter<LoginState> emit) async {
    emit(const LoginLoading());

    // await Future.delayed(Duration(seconds: 3));
    try {
      final token = await repo.submitLogin(
          userName: event.username, password: event.password);
      //TODO: remove
      log(token);
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      //TODO: remove
      log(e.toString());
      emit(state.copyWith(status: LoginStatus.failed));
    }
  }
}
