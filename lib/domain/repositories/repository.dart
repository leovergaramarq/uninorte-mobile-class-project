import 'package:uninorte_mobile_class_project/data/datasources/remote/auth_datasource.dart';
import 'package:uninorte_mobile_class_project/data/datasources/remote/user_datasource.dart';

import 'package:uninorte_mobile_class_project/domain/models/user.dart';

class Repository {
  final AuthDatasource _authDatasource = AuthDatasource();
  final UserDatasource _userDatasource = UserDatasource();
  String token = "";

  // the base url of the API should end without the /
  final String _baseUrl =
      "http://ip172-18-0-57-ck9rncefml8g00an0j10-8000.direct.labs.play-with-docker.com";

  // authentication methods

  Future<bool> login(String email, String password) async {
    token = await _authDatasource.login(_baseUrl, email, password);
    return true;
  }

  Future<bool> signUp(String email, String password) async =>
      await _authDatasource.signUp(_baseUrl, email, password);

  Future<bool> logOut() async => await _authDatasource.logOut();

  // user methods

  Future<List<User>> getUsers() async => await _userDatasource.getUsers();

  Future<bool> addUser(User user) async => await _userDatasource.addUser(user);

  Future<bool> updateUser(User user) async =>
      await _userDatasource.updateUser(user);

  Future<bool> deleteUser(int id) async => await _userDatasource.deleteUser(id);

  Future<bool> simulateProcess() async =>
      await _userDatasource.simulateProcess(_baseUrl, token);

  // question methods
}
