import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'package:uninorte_mobile_class_project/domain/use_case/session_use_case.dart';
import 'package:uninorte_mobile_class_project/domain/models/session.dart';

class SessionController extends GetxController {
  final SessionUseCase _sessionUseCase = SessionUseCase();

  // states
  final Rx<List<Session>> _sessions = Rx<List<Session>>([]);
  final RxBool _areSessionsFetched = RxBool(false);

  List<Session> get sessions => _sessions.value;
  bool get areSessionsFetched => _areSessionsFetched.value;
  int get numSummarizeSessions => SessionUseCase.numSummarizeSessions;

  Future<List<Session>> getSessionsFromUser(String userEmail,
      {int? limit}) async {
    logInfo("Getting sessions");
    if (areSessionsFetched) _areSessionsFetched.value = false;
    List<Session> sessions =
        await _sessionUseCase.getSessionsFromUser(userEmail, limit: limit);
    _sessions.value = sessions;
    _areSessionsFetched.value = true;
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

  void resetSessions() {
    _sessions.value = [];
    _areSessionsFetched.value = false;
  }
}
