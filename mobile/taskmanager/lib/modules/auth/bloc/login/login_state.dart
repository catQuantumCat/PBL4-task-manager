// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failed }

class LoginState extends Equatable {
  final LoginStatus status;
  final String? errorString;
  const LoginState({required this.status, this.errorString});

  const LoginState.failed({
    this.status = LoginStatus.failed,
    required this.errorString,
  });

  @override
  List<Object?> get props => [status, errorString];

  LoginState copyWith({
    LoginStatus? status,
    String? errorString,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorString: errorString ?? this.errorString,
    );
  }
}

class LoginInitial extends LoginState {
  const LoginInitial({super.status = LoginStatus.initial});
}

class LoginLoading extends LoginState {
  const LoginLoading({super.status = LoginStatus.loading});
}

class LoginFailed extends LoginState {
  const LoginFailed(
      {super.status = LoginStatus.failed, required super.errorString});
}
