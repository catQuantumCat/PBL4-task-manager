import 'package:taskmanager/data/datasources/remote/user_remote.datasource.dart';
import 'package:taskmanager/data/dtos/auth_login.dto.dart';

class UserRepository {
  final UserRemoteDatasource _datasource;
  UserRepository({required UserRemoteDatasource datasource})
      : _datasource = datasource;

  Future<String> submitLogin(
      {required String userName, required String password}) async {
    final response = await _datasource
        .submitLogin(AuthLoginDTO(userName: userName, password: password));
    return response.token;
  }
}
