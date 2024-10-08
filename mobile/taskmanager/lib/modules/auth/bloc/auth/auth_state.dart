part of 'auth_bloc.dart';

enum AuthStatus { loading, initial, success, failed }

class AuthState extends Equatable {
  final AuthStatus status;
  
  const AuthState({required this.status});

  @override
  List<Object> get props => [];
}
