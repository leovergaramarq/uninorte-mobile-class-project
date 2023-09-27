import 'package:uninorte_mobile_class_project/domain/repositories/repository.dart';
import 'package:get/get.dart';

class AuthUseCase {
  final Repository _repository = initRepository();

  Future<bool> login(String email, String password) async =>
      await _repository.login(email, password);

  Future<bool> signUp(String email, String password) async =>
      await _repository.signUp(email, password);

  Future<bool> logOut() async => await _repository.logOut();
}

Repository initRepository() {
  return Get.isRegistered<Repository>()
      ? Get.find<Repository>()
      : Get.put<Repository>(Repository());
}
