import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'package:uninorte_mobile_class_project/domain/use_case/session_use_case.dart';
import 'package:uninorte_mobile_class_project/domain/models/session.dart';

class SessionController extends GetxController {
  final SessionUseCase _sessionUseCase = SessionUseCase();
  final Rx<List<Session>> _sessions = Rx<List<Session>>([]);

  List<Session> get sessions => _sessions.value;

  Future<List<Session>> getSessionsFromUser(String userEmail,
      {int? limit}) async {
    logInfo("Getting sessions");
    List<Session> sessions =
        await _sessionUseCase.getSessionsFromUser(userEmail, limit: limit);
    _sessions.value = sessions;
    return sessions;
  }

  Future<Session> addSession(Session session) async {
    logInfo("Add session");
    Session newSession = await _sessionUseCase.addSession(session);
    _sessions.value.add(newSession);
    return newSession;
  }

  // updateSession(Session session) async {
  //   logInfo("Update session");
  //   await _sessionUseCase.updateSession(session);
  //   getSessions();
  // }

  // void deleteSession(int id) async {
  //   await _sessionUseCase.deleteSession(id);
  //   getSessions();
  // }
}
