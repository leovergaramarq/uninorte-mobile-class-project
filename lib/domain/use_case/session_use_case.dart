import 'package:get/get.dart';

// import 'package:uninorte_mobile_class_project/domain/repositories/session_repository.dart';
import 'package:uninorte_mobile_class_project/data/repositories/session_retool_repository.dart';
import 'package:uninorte_mobile_class_project/domain/models/session.dart';

class SessionUseCase {
  // final SessionRetoolRepository _sessionRepository =
  //     Get.find<SessionRetoolRepository>();
  final SessionRetoolRepository _sessionRepository = SessionRetoolRepository();

  // static fields
  static const int numSummarizeSessions = 5;

  Future<List<Session>> getSessionsFromUser(String userEmail,
          {int? limit}) async =>
      await _sessionRepository.getSessionsFromUser(userEmail, limit: limit);

  Future<Session> addSession(Session session) async =>
      await _sessionRepository.addSession(session);

  Future<void> updateSession(Session session) async =>
      await _sessionRepository.updateSession(session);

  Future<bool> deleteSession(int id) async =>
      await _sessionRepository.deleteSession(id);
}
