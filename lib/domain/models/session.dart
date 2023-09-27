import 'package:uninorte_mobile_class_project/domain/models/answer.dart';

class Session {
  Session({
    this.id,
    required this.answers,
    required this.level,
    required this.userEmail,
    required this.totalSeconds,
    required this.numCorrectAnswers,
    required this.numAnswers,
  });

  final int? id;
  final List<Answer> answers;
  final int level;
  final String userEmail;
  final int totalSeconds;
  final int numCorrectAnswers;
  final int numAnswers;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json['id'],
        answers: json['answers'],
        level: json['level'],
        userEmail: json['userEmail'],
        totalSeconds: json['totalSeconds'],
        numCorrectAnswers: json['numCorrectAnswers'],
        numAnswers: json['numAnswers'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'answers': answers,
        'level': level,
        'userEmail': userEmail,
        'totalSeconds': totalSeconds,
        'numCorrectAnswers': numCorrectAnswers,
        'numAnswers': numAnswers,
      };
}
