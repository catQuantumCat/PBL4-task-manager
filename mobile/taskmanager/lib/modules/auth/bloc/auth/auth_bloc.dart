import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager/data/repositories/user.repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;
  AuthBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const AuthState(status: AuthStatus.initial)) {
    _userRepository.authEventStream.listen(
      (event) => add(event),
    );
    on<AuthSetToken>(_setToken);
    on<AuthCheckToken>(_onCheckToken);
    on<AuthLogOut>(_onLogOut);
  }

  @override
  Future<void> close() {
    _userRepository.dispose();
    return super.close();
  }

  void _changeAuthState(String? tokenString, Emitter<AuthState> emit) {
    if (tokenString == null || tokenString.isEmpty) {
      emit(const AuthState.unauthenticated());
      return;
    } else {
      emit(const AuthState.authenticated());
      return;
    }
  }

  void _onCheckToken(AuthCheckToken event, Emitter<AuthState> emit) {
    final tokenString = _userRepository.getToken();
    _changeAuthState(tokenString, emit);
  }

  void _setToken(AuthSetToken event, Emitter<AuthState> emit) {
    _userRepository.setToken(event.tokenString);
    _changeAuthState(event.tokenString, emit);
  }

  void _onLogOut(AuthLogOut event, Emitter<AuthState> emit) async {
    await _userRepository.removeToken();
    emit(const AuthState.unauthenticated());
  }
}
