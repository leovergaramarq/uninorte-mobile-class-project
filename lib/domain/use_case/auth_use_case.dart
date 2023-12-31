// import 'package:get/get.dart';

// import 'package:uninorte_mobile_class_project/domain/repositories/auth_repository.dart';
import 'package:uninorte_mobile_class_project/data/repositories/auth_authserver_repository.dart';

class AuthUseCase {
  // final AuthAuthserverRepository _authRepository =
  //     Get.find<AuthAuthserverRepository>();
  final AuthAuthserverRepository _authRepository = AuthAuthserverRepository();

  Future<String> login(String email, String password) async =>
      await _authRepository.login(email, password);

  Future<void> signUp(String email, String password) async =>
      await _authRepository.signUp(email, password);

  Future<void> logOut() async => await _authRepository.logOut();

  Future<bool> isLoggedIn() async => await _authRepository.isLoggedIn();
}
