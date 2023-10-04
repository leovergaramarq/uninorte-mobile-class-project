import 'dart:convert';
import 'package:loggy/loggy.dart';
import 'package:uninorte_mobile_class_project/domain/models/session.dart';
import 'package:http/http.dart' as http;

class SessionDatasource {
  final String baseUri = 'https://retoolapi.dev/0fkNBk/sum-plus';

  Future<List<Session>> getSessionsFromUser(String userEmail,
      {int? limit}) async {
    List<Session> sessions = [];
    final Uri request = Uri.parse(baseUri).resolveUri(Uri(queryParameters: {
      "format": 'json',
      "userEmail": userEmail,
      if (limit != null) "_limit": limit.toString(),
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

  Future<Session> addSession(Session session) async {
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
      return Future.value(Session.fromJson(jsonDecode(response.body)));
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }
  }
}
