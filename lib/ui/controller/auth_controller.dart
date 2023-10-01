import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'package:uninorte_mobile_class_project/domain/use_case/auth_use_case.dart';

class AuthController extends GetxController {
  final AuthUseCase _authUseCase = initAuthUseCase();
  final RxBool _isLogged = false.obs;
  final RxBool _isGuest = false.obs;

  bool get isLogged => _isLogged.value;
  bool get isGuest => _isGuest.value;

  Future<void> login(email, password) async {
    await _authUseCase.login(email, password);
    _isLogged.value = true;
    if (_isGuest.value) _isGuest.value = false;
  }

  Future<bool> signUp(email, password) async {
    logInfo('Controller Sign Up');
    await _authUseCase.signUp(email, password);
    // _isLogged.value = true;
    // if (_isGuest.value) _isGuest.value = false;
    return true;
  }

  Future<void> logOut() async {
    // if (_isLogged.value) _isLogged.value = false;
    // if (_isGuest.value) _isGuest.value = false;
    _isLogged.value = false;
    _isGuest.value = false;
  }

  Future<void> continueAsGuest() async {
    _isGuest.value = true;
    if (_isLogged.value) _isLogged.value = false;
  }

  void setLoggedIn() {
    _isLogged.value = true;
  }
}

AuthUseCase initAuthUseCase() {
  return Get.isRegistered<AuthUseCase>()
      ? Get.find<AuthUseCase>()
      : Get.put<AuthUseCase>(AuthUseCase());
}
