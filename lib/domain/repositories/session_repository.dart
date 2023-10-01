import 'package:uninorte_mobile_class_project/data/datasources/remote/session_datasource.dart';
import 'package:uninorte_mobile_class_project/domain/models/session.dart';

class SessionRepository {
  final SessionDatasource _sessionDatasource = SessionDatasource();

  Future<List<Session>> getSessions() async =>
      await _sessionDatasource.getSessions();

  Future<bool> addSession(Session Session) async =>
      await _sessionDatasource.addSession(Session);

  Future<bool> updateSession(Session Session) async =>
      await _sessionDatasource.updateSession(Session);

  Future<bool> deleteSession(int id) async =>
      await _sessionDatasource.deleteSession(id);
}
