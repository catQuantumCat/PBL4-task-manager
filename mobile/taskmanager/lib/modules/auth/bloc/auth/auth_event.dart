part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthSetToken extends AuthEvent {
  final String? tokenString;

  const AuthSetToken({required this.tokenString});
  @override
  List<Object?> get props => [tokenString];
}
