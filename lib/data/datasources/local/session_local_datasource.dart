import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:uninorte_mobile_class_project/domain/models/session.dart';

class SessionLocalDatasource {
  SessionLocalDatasource() {
    SharedPreferences.getInstance().then((value) => prefs = value);
  }

  final int maxSessions = 50;
  final String sessionsKey = 'user';
  SharedPreferences? prefs;

  List<Session> getSessionsFromUser(String userEmail, {int? limit}) =>
      _getSessionsFromUser().map((e) => e.data).toList();

  Future<Session> addSession(bool isUpToDate, Session session) async {
    if (prefs == null) {
      return Future.error('SharedPreferences instance doesn\'t exist');
    }
    List<_SessionStore> sessionsStore = _getSessionsFromUser();
    if (sessionsStore.length >= maxSessions) {
      sessionsStore = sessionsStore
          .getRange(
              sessionsStore.length - (maxSessions - 1), sessionsStore.length)
          .toList();
    }

    final sessionStore = _SessionStore(session, isUpToDate);
    sessionsStore.add(
        sessionStore); // Here sessions.length must be less or equal to maxSessions

    final String sessionsString =
        jsonEncode(sessionsStore.map((e) => e.toJson()));

    await prefs!.setString(sessionsKey, sessionsString);
    return session;
  }

  List<_SessionStore> _getSessionsFromUser({int? limit}) {
    if (prefs == null) {
      throw Exception('SharedPreferences instance doesn\'t exist');
    }
    final String? sessionsStoreString = prefs!.getString(sessionsKey);
    if (sessionsStoreString == null) return [];

    final List<Map<String, dynamic>> sessionsStoreMap =
        jsonDecode(sessionsStoreString);

    List<_SessionStore> sessions =
        sessionsStoreMap.map((e) => _SessionStore.fromJson(e)).toList();

    if (limit == null || limit >= sessions.length) return sessions;

    return sessions.getRange(sessions.length - limit, sessions.length).toList();
  }
}

class _SessionStore {
  _SessionStore(this.data, this.isUpToDate);

  final Session data;
  final bool isUpToDate; // whether the data is updated in the backend

  factory _SessionStore.fromJson(Map<String, dynamic> json) => _SessionStore(
        Session.fromJson(json["data"]),
        json["isUpToDate"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "isUpToDate": isUpToDate,
      };
}
