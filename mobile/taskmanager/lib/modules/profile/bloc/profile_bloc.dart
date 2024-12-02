import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/data/model/user_model.dart';
import 'package:taskmanager/data/repositories/user.repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  ProfileBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const ProfileState()) {
    on<ProfileOpen>(_onProfileOpen);
    on<ProfileSetInfo>(_onSetInfo);
    add(const ProfileOpen());
  }

  Future<void> _onProfileOpen(
      ProfileOpen event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final UserModel? userInfo = await _userRepository.getUserInfo();
      if (userInfo == null) {
        emit(const ProfileState.failed(errorMessage: "Cannot get user info!"));
        return;
      }
      emit(ProfileState(status: StateStatus.success, userInfo: userInfo));
    } catch (e) {
      emit(
        ProfileState.failed(errorMessage: e.toString()),
      );
    }
  }

  void _onSetInfo(ProfileSetInfo event, Emitter<ProfileState> emit) async {
    if (state.userInfo == null) {
      emit(const ProfileState.failed(errorMessage: "Cannot get user info!"));
      return;
    }
    emit(state.copyWith(status: StateStatus.loading));

    final newUserInfo = state.userInfo!.copyWith(email: event.email);

    if (newUserInfo == state.userInfo && event.newPassword == null) {
      emit(const ProfileState.failed(errorMessage: "Duplicated data"));
      return;
    }
    if (event.newPassword != null && event.newPassword == event.password) {
      emit(const ProfileState.failed(
          errorMessage: "Duplicated data - Password"));
      return;
    }

    try {
      await _userRepository.editCredential(
          userData: newUserInfo,
          oldPassword: event.password,
          newPassword: event.newPassword);
      emit(state.copyWith(status: StateStatus.success, userInfo: newUserInfo));
    } catch (e) {
      emit(state.copyWith(
          status: StateStatus.failed, errorMessage: e.toString()));
    }
  }
}
