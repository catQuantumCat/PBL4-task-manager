import 'package:hive/hive.dart';
import 'package:taskmanager/common/constants/hive_constant.dart';

class UserLocalDatasource {
  final Box _tokenBox;

  UserLocalDatasource() : _tokenBox = Hive.box(HiveConstant.boxName);

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
}
