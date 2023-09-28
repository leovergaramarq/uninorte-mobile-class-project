import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'package:uninorte_mobile_class_project/domain/use_case/user_use_case.dart';
import 'package:uninorte_mobile_class_project/domain/models/user.dart';

class UserController extends GetxController {
  final UserUseCase _userUseCase = initUserUseCase();
  final RxList<User> _users = <User>[].obs;
  // final Rx<User> _user = Rx<User>(User(
  //   birthDate: '',
  //   email: '',
  //   firstName: '',
  //   lastName: '',
  //   password: '',
  //   degree: '',
  //   school: '',
  // ));
  final RxString _userEmail = ''.obs;

  List<User> get users => _users;
  // User get user => _user.value;
  String get userEmail => _userEmail.value;

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  setUserEmail(String email) {
    _userEmail.value = email;
  }

  getUsers() async {
    logInfo("Getting users");
    _users.value = await _userUseCase.getUsers();
  }

  Future<bool> addUser(User user) async {
    logInfo("Add user");
    bool result = await _userUseCase.addUser(user);
    getUsers();
    return result;
  }

  updateUser(User user) async {
    logInfo("Update user");
    await _userUseCase.updateUser(user);
    getUsers();
  }

  void deleteUser(int id) async {
    await _userUseCase.deleteUser(id);
    getUsers();
  }

  void simulateProcess() async {
    await _userUseCase.simulateProcess();
  }
}

UserUseCase initUserUseCase() {
  return Get.isRegistered<UserUseCase>()
      ? Get.find<UserUseCase>()
      : Get.put<UserUseCase>(UserUseCase());
}
