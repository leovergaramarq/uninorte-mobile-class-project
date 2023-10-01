import 'package:uninorte_mobile_class_project/domain/models/answer.dart';

class Session {
  Session({
    this.id,
    required this.answers,
    required this.userEmail,
    required this.totalSeconds,
    required this.numCorrectAnswers,
    required this.numAnswers,
    required this.avgLevel,
  });

  final int? id;
  final List<Answer> answers;
  final String userEmail;
  int totalSeconds;
  int numCorrectAnswers;
  int numAnswers;
  int avgLevel;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json['id'],
        // answers: json['answers'],
        answers: [],
        userEmail: json['userEmail'],
        totalSeconds: int.parse(json['totalSeconds'].toString()),
        numCorrectAnswers: int.parse(json['numCorrectAnswers'].toString()),
        numAnswers: int.parse(json['numAnswers'].toString()),
        avgLevel: int.parse(json['avgLevel'].toString()),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        // 'answers': answers,
        'userEmail': userEmail,
        'totalSeconds': totalSeconds,
        'numCorrectAnswers': numCorrectAnswers,
        'numAnswers': numAnswers,
        'avgLevel': avgLevel,
      };
}
