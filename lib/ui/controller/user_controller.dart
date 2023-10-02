import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'package:uninorte_mobile_class_project/domain/use_case/user_use_case.dart';
import 'package:uninorte_mobile_class_project/domain/models/user.dart';

class UserController extends GetxController {
  final UserUseCase _userUseCase = UserUseCase();
  final Rx<User> _user = Rx<User>(User.defaultUser());
  final RxBool _userFetched = false.obs;

  User get user => _user.value;
  bool get userFetched => _userFetched.value;

  Future<void> getUser(String email) async {
    logInfo("Getting users");
    _user.value = await _userUseCase.getUser(email);
    _userFetched.value = true;
  }

  Future<User> addUser(User user) async {
    logInfo("Add user");
    return await _userUseCase.addUser(user);
  }

  Future<User> updateUser(User user) async {
    logInfo("Update user");
    return await _userUseCase.updateUser(user);
  }

  void deleteUser(int id) async {
    await _userUseCase.deleteUser(id);
  }

  void resetUser() {
    _user.value = User.defaultUser();
    _userFetched.value = false;
  }
}
