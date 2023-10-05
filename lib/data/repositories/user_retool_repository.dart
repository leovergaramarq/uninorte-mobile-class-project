import 'package:uninorte_mobile_class_project/data/datasources/remote/user_datasource.dart';
import 'package:uninorte_mobile_class_project/data/datasources/local/user_local_datasource.dart';
import 'package:uninorte_mobile_class_project/data/utils/network_util.dart';

import 'package:uninorte_mobile_class_project/domain/models/user.dart';
import 'package:uninorte_mobile_class_project/domain/repositories/user_repository.dart';

class UserRetoolRepository implements UserRepository {
  final UserDatasource _userDatasource = UserDatasource();
  final UserLocalDatasource _userLocalDatasource = UserLocalDatasource();

  final String baseUri = 'https://retoolapi.dev/0zLAjT/sum-plus';

  @override
  Future<User> getUser(String email) async {
    if (await NetworkUtil.hasNetwork(baseUri)) {
      final User user = await _userDatasource.getUser(baseUri, email);
      _userLocalDatasource.addUser(true, user).catchError((e) => print(e));
      return user;
    } else {
      final User? user = _userLocalDatasource.getUser();
      if (user == null) {
        return Future.error('User doesn\'t exist');
      }
      return user;
    }
  }

  @override
  Future<User> addUser(User user) async {
    final User newUser = await _userDatasource.addUser(baseUri, user);
    _userLocalDatasource.addUser(true, newUser).catchError((e) => print(e));
    return newUser;
  }

  @override
  Future<User> updateUser(User user) async {
    if (await NetworkUtil.hasNetwork(baseUri)) {
      final User updatedUser = await _userDatasource.updateUser(baseUri, user);
      _userLocalDatasource
          .updateUser(true, updatedUser)
          .catchError((e) => print(e));
      return updatedUser;
    } else {
      return await _userLocalDatasource.updateUser(false, user);
    }
  }

  @override
  Future<User> updatePartialUser(int id,
      {String? firstName,
      String? lastName,
      String? email,
      String? birthDate,
      String? degree,
      String? school,
      int? level}) async {
    if (await NetworkUtil.hasNetwork(baseUri)) {
      User updatedUser = await _userDatasource.updatePartialUser(baseUri, id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          birthDate: birthDate,
          degree: degree,
          school: school,
          level: level);
      _userLocalDatasource
          .addUser(true, updatedUser)
          .catchError((e) => print(e));
      return updatedUser;
    } else {
      final User updatedUser = await _userLocalDatasource.updatePartialUser(
          false, id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          birthDate: birthDate,
          degree: degree,
          school: school,
          level: level);
      return updatedUser;
    }
  }
}
