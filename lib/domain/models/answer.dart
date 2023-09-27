import 'package:uninorte_mobile_class_project/domain/models/question.dart';

class Answer {
  Answer(
      {required this.question,
      required this.userAnswer,
      required this.seconds,
      required this.userEmail,
      required this.isCorrect});

  final Question question;
  final int userAnswer;
  final int seconds;
  final String userEmail;
  final bool isCorrect;
}
