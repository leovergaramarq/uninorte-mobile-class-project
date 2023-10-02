import 'package:uninorte_mobile_class_project/data/datasources/remote/user_datasource.dart';
import 'package:uninorte_mobile_class_project/domain/models/user.dart';

class UserRepository {
  final UserDatasource _userDatasource = UserDatasource();

  Future<List<User>> getUsers() async => await _userDatasource.getUsers();

  Future<User> getUser(String email) async =>
      await _userDatasource.getUser(email);

  Future<User> addUser(User user) async => await _userDatasource.addUser(user);

  Future<User> updateUser(User user) async =>
      await _userDatasource.updateUser(user);

  Future<bool> deleteUser(int id) async => await _userDatasource.deleteUser(id);
}
