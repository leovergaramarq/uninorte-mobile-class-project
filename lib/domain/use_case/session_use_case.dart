import 'package:loggy/loggy.dart';

import 'package:uninorte_mobile_class_project/domain/repositories/session_repository.dart';
import 'package:uninorte_mobile_class_project/domain/models/session.dart';

class SessionUseCase {
  final SessionRepository _sessionRepository = SessionRepository();

  Future<List<Session>> getSessions() async {
    logInfo("Getting sessions  from UseCase");
    return await _sessionRepository.getSessions();
  }

  Future<bool> addSession(Session session) async =>
      await _sessionRepository.addSession(session);

  Future<void> updateSession(Session session) async =>
      await _sessionRepository.updateSession(session);

  Future<bool> deleteSession(int id) async =>
      await _sessionRepository.deleteSession(id);
}
