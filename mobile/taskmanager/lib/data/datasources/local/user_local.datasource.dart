import 'dart:async';
import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:taskmanager/common/constants/hive_constant.dart';
import 'package:taskmanager/data/dtos/auth_response.dto.dart';
import 'package:taskmanager/data/model/user_model.dart';
import 'package:taskmanager/modules/auth/bloc/auth/auth_bloc.dart';

class UserLocalDatasource {
  final Box _tokenBox;
  UserLocalDatasource() : _tokenBox = Hive.box(HiveConstant.boxName) {
    _tokenBox.watch(key: HiveConstant.token).listen((event) {
      if (event.value == null) {
        _authEventController.add(const AuthLogOut());
      }
    });
  }

  final _authEventController = StreamController<AuthEvent>();

  Stream<AuthEvent> get authEventStream => _authEventController.stream;

  Future<void> dispose() async {
    await _authEventController.close();
  }

  void setCredentials(AuthResponseDTO? userCredentials) async {
    if (userCredentials == null) {
      await _tokenBox.clear();
      return;
    }
    await _tokenBox.put(HiveConstant.token, userCredentials.token);

    final UserModel userInfo = UserModel(
        email: userCredentials.email, username: userCredentials.username);

    await _tokenBox.put(HiveConstant.userInfo, userInfo.toJsonString());

    final String? rawData = _tokenBox.get(HiveConstant.userInfo) as String?;

    log(rawData ?? "NULL", name: "local datasource setCredentials");
  }

  void setUserInfo(UserModel newUserInfo) async {
    await _tokenBox.put(HiveConstant.userInfo, newUserInfo.toJsonString());
  }

  UserModel? getUserInfo() {
    final String? rawData = _tokenBox.get(HiveConstant.userInfo) as String?;

    if (rawData == null) {
      return null;
    }
    return UserModel.fromJsonString(rawData);
  }

  String? getToken() {
    return _tokenBox.get(HiveConstant.token) as String?;
  }

  Future<void> removeCredentials() async {
    await _tokenBox.deleteAll([HiveConstant.token, HiveConstant.userInfo]);
  }
}
