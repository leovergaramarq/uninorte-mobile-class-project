import 'package:uninorte_mobile_class_project/domain/repositories/auth_repository.dart';

import 'package:uninorte_mobile_class_project/data/datasources/remote/auth_datasource.dart';
import 'package:uninorte_mobile_class_project/data/datasources/local/auth_local_datasource.dart';
import 'package:uninorte_mobile_class_project/data/datasources/local/user_local_datasource.dart';

class AuthAuthserverRepository implements AuthRepository {
  // AuthAuthserverRepository() {
  //   try {
  //     String? localToken = _authLocalDatasource.getToken();
  //     if (localToken != null) {
  //       token = localToken;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  final AuthDatasource _authDatasource = AuthDatasource();
  final AuthLocalDatasource _authLocalDatasource = AuthLocalDatasource();
  final UserLocalDatasource _userLocalDatasource =
      UserLocalDatasource(); //TODO: User unique instance with Getx
  // String token = "";
  // the base url of the API should end without the /
  final String _baseUrl =
      "http://ip172-18-0-13-ckecv18gftqg0098hen0-8000.direct.labs.play-with-docker.com";

  @override
  Future<String> login(String email, String password) async {
    final String token = await _authDatasource.login(_baseUrl, email, password);
    if (!(await _authLocalDatasource.saveToken(token))) {
      return Future.error('Token couldn\'t be saved');
    }
    return token;
  }

  @override
  Future<void> signUp(String email, String password) async {
    await _authDatasource.signUp(_baseUrl, email, password);
    if (!(await _authLocalDatasource.saveToken('fakeToken'))) {
      return Future.error('Token couldn\'t be saved');
    }
  }

  @override
  Future<void> logOut() async {
    if (_authLocalDatasource.getToken() != null) {
      if (!(await _authLocalDatasource.removeToken())) {
        return Future.error('Token couldn\'t be removed');
      }
    }

    if (_userLocalDatasource.getUser() != null) {
      if (!(await _userLocalDatasource.removeUser())) {
        return Future.error('User couldn\'t be removed');
      }
    }
  }

  @override
  bool isLoggedin() {
    try {
      return _authLocalDatasource.getToken() != null;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
