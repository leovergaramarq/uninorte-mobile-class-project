import 'package:uninorte_mobile_class_project/data/datasources/remote/session_datasource.dart';
import 'package:uninorte_mobile_class_project/data/datasources/local/session_local_datasource.dart';
import 'package:uninorte_mobile_class_project/data/utils/network_util.dart';

import 'package:uninorte_mobile_class_project/domain/models/session.dart';
import 'package:uninorte_mobile_class_project/domain/repositories/session_repository.dart';

class SessionRetoolRepository implements SessionRepository {
  final SessionDatasource _sessionDatasource = SessionDatasource();
  final SessionLocalDatasource _sessionLocalDatasource =
      SessionLocalDatasource();
  final String baseUri = 'https://retoolapi.dev/0fkNBk/sum-plus';

  @override
  Future<List<Session>> getSessionsFromUser(String userEmail,
      {int? limit}) async {
    if (await NetworkUtil.hasNetwork(baseUri)) {
      return await _sessionDatasource.getSessionsFromUser(
        baseUri,
        userEmail,
        limit: limit,
      );
    } else {
      return _sessionLocalDatasource.getSessionsFromUser(
        userEmail,
        limit: limit,
      );
    }
  }

  @override
  Future<Session> addSession(Session session) async {
    if (await NetworkUtil.hasNetwork(baseUri)) {
      return await _sessionDatasource.addSession(baseUri, session);
    } else {
      return await _sessionLocalDatasource.addSession(false, session);
    }
  }
}
