import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:taskmanager/common/constants/hive_constant.dart';
import 'package:taskmanager/data/datasources/local/user_local.datasource.dart';
import 'package:taskmanager/data/datasources/remote/user_remote.datasource.dart';
import 'package:taskmanager/data/repositories/user.repository.dart';
import 'package:taskmanager/main.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const AuthState(status: AuthStatus.initial)) {
    on<AuthSetToken>(_setToken);
  }

  final UserRepository _userRepository;

  void _changeAuthState(String? tokenString, Emitter<AuthState> emit) {
    if (tokenString == null) {
      emit(const AuthState.unauthenticated());
      return;
    }
    emit(const AuthState.authenticated());
  }

  void _setToken(AuthSetToken event, Emitter<AuthState> emit) {
    _userRepository.setToken(event.tokenString);
    _changeAuthState(event.tokenString, emit);
  }
}
