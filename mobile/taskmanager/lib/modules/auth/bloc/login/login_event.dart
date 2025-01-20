// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitTapped extends LoginEvent {
  final String username;
  final String password;

  const LoginSubmitTapped({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}
