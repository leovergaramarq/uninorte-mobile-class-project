import 'dart:math';
// import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/domain/models/question.dart';
// import 'package:uninorte_mobile_class_project/domain/repositories/question_repository.dart';

import 'package:uninorte_mobile_class_project/domain/models/session.dart';
import 'package:uninorte_mobile_class_project/domain/models/answer.dart';

class QuestionUseCase {
  // static fields
  static const int questionsPerSession = 6;
  static const int maxLevel = 5;
  static const int minCorrectToLevelUp = 2;
  static const int minWrongToLevelDown = 2;

  Question getQuestion(int level) {
    Random random = Random();

    // Calculate the range for random numbers based on the number of digits
    int minRange = pow(10, level - 1).toInt();
    int maxRange = pow(10, level).toInt() - 1;

    // Generate random numbers within the specified range
    int num1 = minRange + random.nextInt(maxRange - minRange);
    int num2 = minRange + random.nextInt(maxRange - minRange);

    return Question(num1, '+', num2);
  }

  bool isAnswerCorrect(Question question, int answer) =>
      answer == question.getAnswer();

  int concatTypedNumber(currAnswer, typedNumber) =>
      int.parse(currAnswer.toString() + typedNumber.toString());

  bool areAllQuestionsAnswered(List<Answer> answers) =>
      answers.length >= questionsPerSession;

  int getNewLevel(Session session, int level) {
    int boundLevel(int newLevel) {
      return min(max(newLevel, 1), maxLevel);
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
          if (answer.seconds <=
              getSecondsExpectedForLevel(answer.question.level)) {
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

  int getSecondsExpectedForLevel(int level) {
    return 8 * level;
  }
}
