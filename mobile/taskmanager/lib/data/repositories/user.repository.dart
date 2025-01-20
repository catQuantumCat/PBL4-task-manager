import 'dart:async';

import 'package:taskmanager/data/datasources/local/user_local.datasource.dart';
import 'package:taskmanager/data/datasources/remote/user_remote.datasource.dart';
import 'package:taskmanager/data/dtos/auth_edit.dto.dart';
import 'package:taskmanager/data/dtos/auth_login.dto.dart';
import 'package:taskmanager/data/dtos/auth_register.dto.dart';
import 'package:taskmanager/data/dtos/auth_response.dto.dart';
import 'package:taskmanager/data/model/user_model.dart';
import 'package:taskmanager/modules/auth/bloc/auth/auth_bloc.dart';

class UserRepository {
  final UserRemoteDatasource _remoteSource;
  final UserLocalDatasource _localSource;

  Stream<AuthEvent> get authEventStream => _localSource.authEventStream;

  UserRepository({
    required UserRemoteDatasource remoteSource,
    required UserLocalDatasource localSource,
  })  : _remoteSource = remoteSource,
        _localSource = localSource;

  Future<AuthResponseDTO> submitLogin({
    required String userName,
    required String password,
  }) async {
    final response = await _remoteSource
        .submitLogin(AuthLoginDTO(userName: userName, password: password));

    return response;
  }

  Future<AuthResponseDTO> submitRegister({
    required String email,
    required String username,
    required String password,
  }) async {
    final response = await _remoteSource.submitRegister(
        AuthRegisterDTO(username: username, email: email, password: password));

    return response;
  }

  void setCredentials(AuthResponseDTO? userCredentials) {
    _localSource.setCredentials(userCredentials);
  }

  Future<void> editCredential(
      {required UserModel userData,
      required String oldPassword,
      required String? newPassword}) async {
    final UserModel newData = await _remoteSource.changeCredentials(AuthEditDTO(
        username: userData.username,
        email: userData.email,
        oldPassword: oldPassword,
        newPassword: newPassword ?? oldPassword));

    if (newPassword == null) _localSource.setUserInfo(newData);
    return;
  }

  String? getToken() {
    return _localSource.getToken();
  }

  Future<UserModel?> getUserInfo() {
    return _localSource.getUserInfo();
  }

  Future<void> dispose() async {
    await _localSource.dispose();
  }

  Future<void> removeToken() async {
    await _localSource.removeCredentials();
  }
}
