import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  AuthLocalDatasource() {
    SharedPreferences.getInstance().then((value) => prefs = value);
  }

  final String tokenKey = 'authToken';
  SharedPreferences? prefs;

  Future<bool> saveToken(String token) async {
    if (prefs == null) {
      return Future.error('SharedPreferences instance doesn\'t exist');
    }
    return await prefs!.setString(tokenKey, token);
  }

  String? getToken() {
    if (prefs == null) {
      throw Exception('SharedPreferences instance doesn\'t exist');
    }
    return prefs!.getString(tokenKey);
  }

  Future<bool> removeToken() async {
    if (prefs == null) {
      return Future.error('SharedPreferences instance doesn\'t exist');
    }
    return await prefs!.remove(tokenKey);
  }
}
