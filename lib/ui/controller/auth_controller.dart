import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'package:uninorte_mobile_class_project/domain/use_case/auth_use_case.dart';

class AuthController extends GetxController {
  final AuthUseCase _authUseCase = initAuthUseCase();
  final RxBool logged = false.obs;

  bool get isLogged => logged.value;

  Future<void> login(email, password) async {
    await _authUseCase.login(email, password);
    logged.value = true;
  }

  Future<bool> signUp(email, password) async {
    logInfo('Controller Sign Up');
    await _authUseCase.signUp(email, password);
    return true;
  }

  Future<void> logOut() async {
    logged.value = false;
  }
}

AuthUseCase initAuthUseCase() {
  return Get.isRegistered<AuthUseCase>()
      ? Get.find<AuthUseCase>()
      : Get.put<AuthUseCase>(AuthUseCase());
}
