// import 'package:uninorte_mobile_class_project/data/datasources/remote/session_datasource.dart';
import 'package:uninorte_mobile_class_project/domain/models/session.dart';

abstract class SessionRepository {
  Future<List<Session>> getSessionsFromUser(String userEmail, {int? limit});

  Future<Session> addSession(Session session);
}
