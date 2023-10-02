import 'package:uninorte_mobile_class_project/data/datasources/remote/session_datasource.dart';

import 'package:uninorte_mobile_class_project/domain/models/session.dart';
import 'package:uninorte_mobile_class_project/domain/repositories/session_repository.dart';

class SessionRetoolRepository implements SessionRepository {
  final SessionDatasource _sessionDatasource = SessionDatasource();

  Future<List<Session>> getSessionsFromUser(String userEmail,
          {int? limit}) async =>
      await _sessionDatasource.getSessionsFromUser(
        userEmail,
        limit: limit,
      );

  Future<Session> addSession(Session Session) async =>
      await _sessionDatasource.addSession(Session);

  Future<bool> updateSession(Session Session) async =>
      await _sessionDatasource.updateSession(Session);

  Future<bool> deleteSession(int id) async =>
      await _sessionDatasource.deleteSession(id);
}
