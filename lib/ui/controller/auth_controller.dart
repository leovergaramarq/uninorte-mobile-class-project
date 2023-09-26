import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'package:uninorte_mobile_class_project/domain/use_case/auth_use_case.dart';

class AuthController extends GetxController {
  final logged = false.obs;

  bool get isLogged => logged.value;

  Future<void> login(email, password) async {
    final AuthUseCase auth = Get.find();
    await auth.login(email, password);
    logged.value = true;
  }

  Future<bool> signUp(email, password) async {
    final AuthUseCase authentication = Get.find();
    logInfo('Controller Sign Up');
    await authentication.signUp(email, password);
    return true;
  }

  Future<void> logOut() async {
    logged.value = false;
  }
}
