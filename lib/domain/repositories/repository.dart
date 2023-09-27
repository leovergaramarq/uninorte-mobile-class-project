import 'package:uninorte_mobile_class_project/data/datasources/remote/auth_datasource.dart';
import 'package:uninorte_mobile_class_project/data/datasources/remote/user_datasource.dart';
import 'package:uninorte_mobile_class_project/data/datasources/remote/session_datasource.dart';
import 'package:uninorte_mobile_class_project/data/datasources/local/question_datasource.dart';

import 'package:uninorte_mobile_class_project/domain/models/user.dart';
import 'package:uninorte_mobile_class_project/domain/models/session.dart';

class Repository {
  final AuthDatasource _authDatasource = AuthDatasource();
  final UserDatasource _userDatasource = UserDatasource();
  final SessionDatasource _sessionDatasource = SessionDatasource();
  final QuestionDatasource _questionDatasource = QuestionDatasource();
  String token = "";

  // the base url of the API should end without the /
  final String _baseUrl =
      "http://ip172-19-0-46-cka7c9ksnmng00dvqn60-8000.direct.labs.play-with-docker.com";

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

  Future<bool> simulateProcessUser() async =>
      await _userDatasource.simulateProcess(_baseUrl, token);

  // user methods

  Future<List<Session>> getSessions() async =>
      await _sessionDatasource.getSessions();

  Future<bool> addSession(Session Session) async =>
      await _sessionDatasource.addSession(Session);

  Future<bool> updateSession(Session Session) async =>
      await _sessionDatasource.updateSession(Session);

  Future<bool> deleteSession(int id) async =>
      await _sessionDatasource.deleteSession(id);

  Future<bool> simulateProcessSession() async =>
      await _sessionDatasource.simulateProcess(_baseUrl, token);

  // question methods
  List<List<dynamic>> getQuestions() => _questionDatasource.getQuestions();
}
