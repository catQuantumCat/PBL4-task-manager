// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileOpen extends ProfileEvent {
  const ProfileOpen();
}

class ProfileSetInfo extends ProfileEvent {
  final String? email;
  final String? newPassword;
  final String password;

  const ProfileSetInfo({this.email, required this.password, this.newPassword});

  @override
  List<Object?> get props => [email, password, newPassword];
}
