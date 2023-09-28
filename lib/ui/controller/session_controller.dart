import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'package:uninorte_mobile_class_project/domain/use_case/session_use_case.dart';
import 'package:uninorte_mobile_class_project/domain/models/session.dart';

class SessionController extends GetxController {
  final SessionUseCase _sessionUseCase = initSessionUseCase();
  final RxList<Session> _sessions = <Session>[].obs;

  List<Session> get sessions => _sessions;

  @override
  void onInit() {
    getSessions();
    super.onInit();
  }

  getSessions() async {
    logInfo("Getting sessions");
    _sessions.value = await _sessionUseCase.getSessions();
  }

  Future<bool> addSession(Session session) async {
    logInfo("Add session");
    bool result = await _sessionUseCase.addSession(session);
    getSessions();
    return result;
  }

  updateSession(Session session) async {
    logInfo("Update session");
    await _sessionUseCase.updateSession(session);
    getSessions();
  }

  void deleteSession(int id) async {
    await _sessionUseCase.deleteSession(id);
    getSessions();
  }

  void simulateProcess() async {
    await _sessionUseCase.simulateProcess();
  }
}

SessionUseCase initSessionUseCase() {
  return Get.isRegistered<SessionUseCase>()
      ? Get.find<SessionUseCase>()
      : Get.put<SessionUseCase>(SessionUseCase());
}
