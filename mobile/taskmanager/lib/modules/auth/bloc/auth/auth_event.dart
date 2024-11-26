part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthSetInfo extends AuthEvent {
  // final String? tokenString;
  final AuthResponseDTO userCredentials;

  const AuthSetInfo({required this.userCredentials});
  @override
  List<Object?> get props => [userCredentials];
}

class AuthCheckToken extends AuthEvent {
  const AuthCheckToken();
}

class AuthLogOut extends AuthEvent {
  const AuthLogOut();
}
