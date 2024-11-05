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

  void _onProfileOpen(ProfileOpen event, Emitter<ProfileState> emit) {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final UserModel? userInfo = _userRepository.getUserInfo();
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

  void _onSetInfo(ProfileSetInfo event, Emitter<ProfileState> emit) {
    if (state.userInfo == null) {
      emit(const ProfileState.failed(errorMessage: "Cannot get user info!"));
      return;
    }
    emit(state.copyWith(status: StateStatus.loading));

    final newUserInfo =
        state.userInfo!.copyWith(username: event.username, email: event.email);

    if (newUserInfo == state.userInfo) {
      emit(const ProfileState.failed(errorMessage: "Duplicated data"));
      return;
    }
    if (event.newPassword != null && event.newPassword == event.password) {
      emit(const ProfileState.failed(
          errorMessage: "Duplicated data - Password"));
      return;
    }

    try {
      _userRepository.setUserInfo(newUserInfo);
      emit(state.copyWith(status: StateStatus.success, userInfo: newUserInfo));
    } catch (e) {
      emit(ProfileState.failed(errorMessage: e.toString()));
    }
  }
}
