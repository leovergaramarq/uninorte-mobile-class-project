import 'dart:convert';
import 'package:loggy/loggy.dart';
import 'package:http/http.dart' as http;

import 'package:uninorte_mobile_class_project/domain/models/user.dart';

class UserDatasource {
  final String baseUri = 'https://retoolapi.dev/0zLAjT/sum-plus';

  Future<List<User>> getUsers() async {
    List<User> users = [];
    final Uri request = Uri.parse(baseUri).resolveUri(Uri(queryParameters: {
      "format": 'json',
    }));

    final http.Response response = await http.get(request);

    if (response.statusCode == 200) {
      //logInfo(response.body);
      final data = jsonDecode(response.body);

      users = List<User>.from(data.map((x) => User.fromJson(x)));
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }

    return Future.value(users);
  }

  Future<User> getUser(String email) async {
    final Uri request = Uri.parse(baseUri).resolveUri(Uri(queryParameters: {
      "format": 'json',
      "email": email,
    }));

    final http.Response response = await http.get(request);

    if (response.statusCode == 200) {
      //logInfo(response.body);
      final data = jsonDecode(response.body);

      List<User> users = List<User>.from(data.map((x) => User.fromJson(x)));
      print(data);
      if (users.length != 0) return users[0];
      return Future.error('User not found');
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }
  }

  Future<User> addUser(User user) async {
    logInfo("Web service, Adding user");

    final response = await http.post(
      Uri.parse(baseUri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      //logInfo(response.body);
      return Future.value(User.fromJson(jsonDecode(response.body)));
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }
  }

  Future<User> updateUser(User user) async {
    final response = await http.put(
      Uri.parse("$baseUri/${user.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    // print(response.statusCode);

    if (response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(User.fromJson(jsonDecode(response.body)));
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }
  }

  Future<User> updatePartialUser(int id,
      {String? firstName,
      String? lastName,
      String? email,
      String? birthDate,
      String? degree,
      String? school,
      int? level}) async {
    final response = await http.patch(
      Uri.parse("$baseUri/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          if (firstName != null) 'firstName': firstName,
          if (lastName != null) 'lastName': lastName,
          if (email != null) 'email': email,
          if (birthDate != null) 'birthDate': birthDate,
          if (degree != null) 'degree': degree,
          if (school != null) 'school': school,
          if (level != null) 'level': level,
        },
      ),
    );

    // print(response.statusCode);

    if (response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(User.fromJson(jsonDecode(response.body)));
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }
  }

  Future<bool> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUri/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> simulateProcess(String baseUrl, String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/me"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    logInfo(response.statusCode);
    if (response.statusCode == 200) {
      logInfo('simulateProcess access ok');
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }
  }
}
