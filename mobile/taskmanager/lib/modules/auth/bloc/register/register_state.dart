part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({required this.status, this.errorString});

  const RegisterState.initial(
      {this.status = StateStatus.initial, this.errorString});

  const RegisterState.loading(
      {this.status = StateStatus.loading, this.errorString});

  const RegisterState.failed(
      {this.status = StateStatus.failed, required this.errorString});

  const RegisterState.success(
      {this.status = StateStatus.success, this.errorString});

  final StateStatus status;
  final String? errorString;

  @override
  List<Object?> get props => [status, errorString];
}
