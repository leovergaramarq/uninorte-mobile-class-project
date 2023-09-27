import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'package:uninorte_mobile_class_project/domain/repositories/repository.dart';
import 'package:uninorte_mobile_class_project/domain/models/session.dart';

class SessionUseCase {
  final Repository _repository = initRepository();

  SessionUseCase();

  Future<List<Session>> getSessions() async {
    logInfo("Getting sessions  from UseCase");
    return await _repository.getSessions();
  }

  Future<bool> addSession(Session session) async =>
      await _repository.addSession(session);

  Future<void> updateSession(Session session) async =>
      await _repository.updateSession(session);

  deleteSession(int id) async => await _repository.deleteSession(id);

  simulateProcess() async => await _repository.simulateProcessUser();
}

Repository initRepository() {
  return Get.isRegistered<Repository>()
      ? Get.find<Repository>()
      : Get.put<Repository>(Repository());
}
