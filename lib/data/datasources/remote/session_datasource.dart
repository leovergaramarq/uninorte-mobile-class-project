import 'dart:convert';
import 'package:loggy/loggy.dart';
import 'package:uninorte_mobile_class_project/domain/models/session.dart';
import 'package:http/http.dart' as http;

class SessionDatasource {
  final String baseUri = 'https://retoolapi.dev/x74Ldx/sum-plus';

  Future<List<Session>> getSessions() async {
    List<Session> sessions = [];
    final Uri request = Uri.parse(baseUri).resolveUri(Uri(queryParameters: {
      "format": 'json',
    }));

    final http.Response response = await http.get(request);

    if (response.statusCode == 200) {
      //logInfo(response.body);
      final data = jsonDecode(response.body);

      sessions = List<Session>.from(data.map((x) => Session.fromJson(x)));
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }

    return Future.value(sessions);
  }

  Future<bool> addSession(Session session) async {
    logInfo("Web service, Adding session");

    final response = await http.post(
      Uri.parse(baseUri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(session.toJson()),
    );

    if (response.statusCode == 201) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> updateSession(Session session) async {
    final response = await http.put(
      Uri.parse("$baseUri/${session.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(session.toJson()),
    );

    if (response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  Future<bool> deleteSession(int id) async {
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
