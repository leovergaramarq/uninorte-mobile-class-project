import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'package:uninorte_mobile_class_project/domain/use_case/user_use_case.dart';
import 'package:uninorte_mobile_class_project/domain/models/user.dart';

class UserController extends GetxController {
  final UserUseCase _userUseCase = UserUseCase();
  final Rx<List<User>> _users = Rx<List<User>>([]);
  final Rx<User> _user = Rx<User>(User(
    birthDate: '',
    email: '',
    firstName: '',
    lastName: '',
    password: '',
    degree: '',
    school: '',
  ));
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

  List<User> get users => _users.value;
  User get user => _user.value;
  String get userEmail => _userEmail.value;

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  void setUserEmail(String email) {
    _userEmail.value = email;
  }

  Future<List<User>> getUsers() async {
    logInfo("Getting users");
    List<User> users = await _userUseCase.getUsers();
    _users.value = users;
    return users;
  }

  Future<User> getUser(String email) async {
    logInfo("Getting users");
    User user = await _userUseCase.getUser(email);
    _user.value = user;
    return user;
  }

  Future<bool> addUser(User user) async {
    logInfo("Add user");
    bool result = await _userUseCase.addUser(user);
    // getUsers();
    return result;
  }

  Future<bool> updateUser(User user) async {
    logInfo("Update user");
    bool result = await _userUseCase.updateUser(user);
    // getUsers();
    return result;
  }

  void deleteUser(int id) async {
    await _userUseCase.deleteUser(id);
    getUsers();
  }
}
