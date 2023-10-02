import 'dart:math';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/domain/models/question.dart';
import 'package:uninorte_mobile_class_project/domain/repositories/question_repository.dart';

import 'package:uninorte_mobile_class_project/domain/models/session.dart';
import 'package:uninorte_mobile_class_project/domain/models/answer.dart';

class QuestionUseCase {
  final QuestionRepository _questionRepository = Get.find<QuestionRepository>();
  // static fields
  static const int questionsPerSession = 6;
  static const int maxLevel = 5;
  static const int minCorrectToLevelUp = 2;
  static const int minWrongToLevelDown = 2;

  Future<Question> getQuestion(int level) async =>
      await _questionRepository.getQuestion(level);

  int getQuestionAnswer(Question question) => question.getAnswer();

  bool isAnswerCorrect(Question question, int answer) =>
      answer == getQuestionAnswer(question);

  int concatTypedNumber(currAnswer, typedNumber) =>
      int.parse(currAnswer.toString() + typedNumber.toString());

  bool areAllQuestionsAnswered(List<Answer> answers) =>
      answers.length >= questionsPerSession;

  int getNewLevel(Session session, int level) {
    int boundLevel(int newLevel) {
      return min(max(newLevel, 1), 5);
    }

    List<Answer> answers = session.answers;
    if (answers.length >= minCorrectToLevelUp) {
      List<Answer> lastAnswers = answers
          .getRange(answers.length - minCorrectToLevelUp, answers.length)
          .toList();

      if (!lastAnswers.every(
          (answer) => answer.question.level == lastAnswers[0].question.level)) {
        return boundLevel(level);
      }

      int numCorrect = 0;
      int numCorrectInTime = 0;

      for (Answer answer in lastAnswers) {
        if (answer.isCorrect) {
          numCorrect++;
          if (answer.seconds <= answer.question.level * 6) {
            numCorrectInTime++;
          }
        }
      }

      if (numCorrect >= minCorrectToLevelUp) {
        if (numCorrectInTime >= numCorrect / 2) {
          return boundLevel(level + 1);
        } else {
          return boundLevel(level);
        }
      } else if (lastAnswers.length - numCorrect >= minWrongToLevelDown) {
        return boundLevel(level - 1);
      } else {
        return boundLevel(level);
      }
    } else {
      return boundLevel(level);
    }
  }
}
