import 'package:uninorte_mobile_class_project/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository = AuthRepository();

  Future<bool> login(String email, String password) async =>
      await _authRepository.login(email, password);

  Future<bool> signUp(String email, String password) async =>
      await _authRepository.signUp(email, password);

  Future<bool> logOut() async => await _authRepository.logOut();
}
