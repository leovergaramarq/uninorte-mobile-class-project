import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'package:uninorte_mobile_class_project/domain/use_case/auth_use_case.dart';

class AuthController extends GetxController {
  final AuthUseCase _authUseCase = AuthUseCase();
  final RxBool _isLoggedIn = false.obs;
  final RxBool _isGuest = false.obs;

  bool get isLoggedIn => _isLoggedIn.value;
  bool get isGuest => _isGuest.value;

  Future<String> login(email, password) async {
    String token = await _authUseCase.login(email, password);
    _isLoggedIn.value = true;
    if (_isGuest.value) _isGuest.value = false;
    return token;
  }

  Future<void> signUp(email, password) async {
    logInfo('Controller Sign Up');
    await _authUseCase.signUp(email, password);
    _isLoggedIn.value = true;
    if (_isGuest.value) _isGuest.value = false;
  }

  Future<void> logOut() async {
    // if (_isLogged.value) _isLogged.value = false;
    // if (_isGuest.value) _isGuest.value = false;
    _isLoggedIn.value = false;
    _isGuest.value = false;
  }

  Future<void> continueAsGuest() async {
    _isGuest.value = true;
    if (_isLoggedIn.value) _isLoggedIn.value = false;
  }

  // void setLoggedIn() {
  //   _isLogged.value = true;
  // }
}
