import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:uninorte_mobile_class_project/domain/models/user.dart';

class UserLocalDatasource {
  UserLocalDatasource() {
    SharedPreferences.getInstance().then((value) => prefs = value);
  }

  final String userKey = 'user';
  SharedPreferences? prefs;

  User? getUser() {
    final _UserStore? userStore = _getUser();
    if (userStore == null) return null;
    return userStore.data;
  }

  Future<User> addUser(bool isUpToDate, User user) async =>
      await _addUser(isUpToDate, user);

  Future<User> updateUser(bool isUpToDate, User user) async =>
      await addUser(isUpToDate, user);

  Future<User> updatePartialUser(bool isUpToDate, int id,
      {String? firstName,
      String? lastName,
      String? email,
      String? birthDate,
      String? degree,
      String? school,
      int? level}) async {
    if (prefs == null) {
      return Future.error('SharedPreferences instance doesn\'t exist');
    }

    final _UserStore? userStore = _getUser();
    if (userStore == null) {
      return Future.error('User doesn\'t exist');
    }
    final User user = userStore.data;

    if (firstName != null) user.firstName = firstName;
    if (lastName != null) user.lastName = lastName;
    if (email != null) user.email = email;
    if (birthDate != null) user.birthDate = birthDate;
    if (degree != null) user.degree = degree;
    if (school != null) user.school = school;
    if (level != null) user.level = level;

    return await _addUser(isUpToDate, user);
  }

  _UserStore? _getUser() {
    if (prefs == null) {
      throw Exception('SharedPreferences instance doesn\'t exist');
    }
    final String? userString = prefs!.getString(userKey);
    if (userString == null) return null;
    final Map<String, dynamic> userStoreMap = jsonDecode(userString);
    return _UserStore.fromJson(userStoreMap);
  }

  Future<User> _addUser(bool isUpToDate, User user) async {
    if (prefs == null) {
      return Future.error('SharedPreferences instance doesn\'t exist');
    }
    final _UserStore userStore = _UserStore(user, isUpToDate);
    final String userString = jsonEncode(userStore.toJson());
    final bool result = await prefs!.setString(userKey, userString);
    if (!result) {
      return Future.error('User couldn\'t be saved');
    }
    return user;
  }

  Future<bool> removeUser() async {
    if (prefs == null) {
      return Future.error('SharedPreferences instance doesn\'t exist');
    }
    return await prefs!.remove(userKey);
  }
}

class _UserStore {
  _UserStore(this.data, this.isUpToDate);

  final User data;
  final bool isUpToDate; // whether the data is updated in the backend

  factory _UserStore.fromJson(Map<String, dynamic> json) => _UserStore(
        User.fromJson(json["data"]),
        json["isUpToDate"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "isUpToDate": isUpToDate,
      };
}
