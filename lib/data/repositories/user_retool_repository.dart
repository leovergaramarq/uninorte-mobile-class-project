import 'package:uninorte_mobile_class_project/data/datasources/remote/user_datasource.dart';

import 'package:uninorte_mobile_class_project/domain/models/user.dart';
import 'package:uninorte_mobile_class_project/domain/repositories/user_repository.dart';

class UserRetoolRepository implements UserRepository {
  final UserDatasource _userDatasource = UserDatasource();

  Future<List<User>> getUsers() async => await _userDatasource.getUsers();

  Future<User> getUser(String email) async =>
      await _userDatasource.getUser(email);

  Future<User> addUser(User user) async => await _userDatasource.addUser(user);

  Future<User> updateUser(User user) async =>
      await _userDatasource.updateUser(user);

  Future<User> updatePartialUser(int id,
          {String? firstName,
          String? lastName,
          String? email,
          String? birthDate,
          String? degree,
          String? school,
          int? level}) async =>
      await _userDatasource.updatePartialUser(id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          birthDate: birthDate,
          degree: degree,
          school: school,
          level: level);

  Future<bool> deleteUser(int id) async => await _userDatasource.deleteUser(id);
}
