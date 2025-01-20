part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated, initial }

class AuthState extends Equatable {
  final AuthStatus status;

  const AuthState({required this.status});

  const AuthState.authenticated({this.status = AuthStatus.authenticated});

  const AuthState.unauthenticated({this.status = AuthStatus.unauthenticated});

  @override
  List<Object> get props => [status];
}
