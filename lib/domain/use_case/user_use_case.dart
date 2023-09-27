import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'package:uninorte_mobile_class_project/domain/repositories/repository.dart';
import 'package:uninorte_mobile_class_project/domain/models/user.dart';

class UserUseCase {
  final Repository _repository = initRepository();

  UserUseCase();

  Future<List<User>> getUsers() async {
    logInfo("Getting users  from UseCase");
    return await _repository.getUsers();
  }

  Future<bool> addUser(User user) async => await _repository.addUser(user);

  Future<void> updateUser(User user) async =>
      await _repository.updateUser(user);

  deleteUser(int id) async => await _repository.deleteUser(id);

  simulateProcess() async => await _repository.simulateProcessUser();
}

Repository initRepository() {
  return Get.isRegistered<Repository>()
      ? Get.find<Repository>()
      : Get.put<Repository>(Repository());
}
