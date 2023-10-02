import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/domain/repositories/user_repository.dart';
import 'package:uninorte_mobile_class_project/domain/models/user.dart';

class UserUseCase {
  final UserRepository _userRepository = Get.find<UserRepository>();

  UserUseCase();

  Future<List<User>> getUsers() async {
    return await _userRepository.getUsers();
  }

  Future<User> getUser(String email) async {
    return await _userRepository.getUser(email);
  }

  Future<User> addUser(User user) async => await _userRepository.addUser(user);

  Future<User> updateUser(User user) async =>
      await _userRepository.updateUser(user);

  deleteUser(int id) async => await _userRepository.deleteUser(id);
}
