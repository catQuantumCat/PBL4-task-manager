import 'package:taskmanager/config/router/user_local.datasource.dart';
import 'package:taskmanager/data/datasources/remote/user_remote.datasource.dart';
import 'package:taskmanager/data/dtos/auth_login.dto.dart';
import 'package:taskmanager/data/dtos/auth_register.dto.dart';

class UserRepository {
  final UserRemoteDatasource _remoteSource;
  final UserLocalDatasource _localSource;
  UserRepository({
    required UserRemoteDatasource remoteSource,
    required UserLocalDatasource localSource,
  })  : _remoteSource = remoteSource,
        _localSource = localSource;

  Future<String> submitLogin({
    required String userName,
    required String password,
  }) async {
    final response = await _remoteSource
        .submitLogin(AuthLoginDTO(userName: userName, password: password));
    return response.token;
  }

  Future<String> submitRegister({
    required String email,
    required String username,
    required String password,
  }) async {
    final response = await _remoteSource.submitRegister(
        AuthRegisterDTO(username: username, email: email, password: password));

    return response.token;
  }

  void setToken(String? tokenString) {
    _localSource.setToken(tokenString);
  }

  String? getToken() {
    return _localSource.getToken();
  }
}
