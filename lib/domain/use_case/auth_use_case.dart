import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  Future<String> login(String email, String password) async =>
      await _authRepository.login(email, password);

  Future<void> signUp(String email, String password) async =>
      await _authRepository.signUp(email, password);

  Future<bool> logOut() async => await _authRepository.logOut();
}
