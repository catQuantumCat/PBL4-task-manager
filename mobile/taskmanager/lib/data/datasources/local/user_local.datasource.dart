import 'dart:async';

import 'package:hive/hive.dart';
import 'package:taskmanager/common/constants/hive_constant.dart';
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

  void setToken(String? tokenString) async {
    if (tokenString == null) {
      await _tokenBox.clear();
      return;
    }

    await _tokenBox.put(HiveConstant.token, tokenString);
  }

  String? getToken() {
    return _tokenBox.get(HiveConstant.token) as String?;
  }

  Future<void> removeToken() async {
    return _tokenBox.delete(HiveConstant.token);
  }
}
