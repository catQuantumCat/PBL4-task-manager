// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.status = StateStatus.initial,
    this.userInfo,
    this.errorMessage,
  });
  final StateStatus status;
  final UserModel? userInfo;
  final String? errorMessage;

  const ProfileState.failed(
      {this.status = StateStatus.failed,
      this.userInfo,
      required this.errorMessage});

  @override
  List<Object?> get props => [status, userInfo, errorMessage];

  ProfileState copyWith({
    StateStatus? status,
    UserModel? userInfo,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      userInfo: userInfo ?? this.userInfo,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
