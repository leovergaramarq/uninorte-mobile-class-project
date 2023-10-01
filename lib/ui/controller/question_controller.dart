import 'dart:math';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/domain/use_case/question_use_case.dart';

import 'package:uninorte_mobile_class_project/domain/models/question.dart';
import 'package:uninorte_mobile_class_project/domain/models/session.dart';
import 'package:uninorte_mobile_class_project/domain/models/answer.dart';

class QuestionController extends GetxController {
  // static fields
  static const int questionsPerSession = 6;
  static const int maxLevel = 5;
  static const int minCorrectToLevelUp = 2;
  static const int minWrongToLevelDown = 2;

  // attributes
  final QuestionUseCase _questionUseCase = QuestionUseCase();
  // final RxInt _levelIndex = 0.obs;
  // final RxInt _questionIndex = 0.obs;
  final RxInt _level = 1.obs;
  final RxInt _userAnswer = 0.obs;
  // final Rx<Question> _question = Rx<Question>(Question(0, '', 0));
  // final Rx<List<List<Question>>> _questions = Rx<List<List<Question>>>([]);
  final Rx<Question> _question = Rx<Question>(Question(0, '', 0));
  final RxBool _isQuestionReady = false.obs;
  final RxBool _didAnswer = false.obs;
  final Rx<Session> _session = Rx<Session>(Session(
      userEmail: '',
      answers: [],
      numCorrectAnswers: 0,
      numAnswers: 0,
      totalSeconds: 0,
      avgLevel: 0));
  final RxBool _isSessionActive = false.obs;
  final _answerSeconds = 0.obs;

  // Getters
  // int get levelIndex => _levelIndex.value;
  // int get questionIndex => _questionIndex.value;
  int get level => _level.value;
  int get userAnswer => _userAnswer.value;
  Question get question => _question.value;
  // List<List<Question>> get questions => _questions.value;
  bool get isQuestionReady => _isQuestionReady.value;
  bool get didAnswer => _didAnswer.value;
  Session get session => _session.value;
  bool get isSessionActive => _isSessionActive.value;
  int get answerSeconds => _answerSeconds.value;

  void startSession(String userEmail) {
    if (isSessionActive) {
      print('session is already active');
      return;
    }

    if (userEmail.isEmpty) {
      print('email is empty');
    }
    _session.value = Session(
        userEmail: userEmail,
        answers: [],
        numCorrectAnswers: 0,
        numAnswers: 0,
        totalSeconds: 0,
        avgLevel: 0);
    _isSessionActive.value = true;
  }

  void finishSession() {
    if (!isSessionActive) {
      print('session is not active');
      return;
    }

    // Summarize session
    // _session.value.numAnswers = _session.value.answers.length;
    // _session.value.numCorrectAnswers =
    //     _session.value.answers.where((answer) => answer.isCorrect).length;
    // _session.value.totalSeconds = _session.value.answers
    //     .map((answer) => answer.seconds)
    //     .reduce((value, element) => value + element);

    // Reset values
    // _levelIndex.value = 0;
    // _questionIndex.value = 0;
    // _level.value = 1;
    _userAnswer.value = 0;
    // _questions.value = [];
    _question.value = Question(0, '', 0);
    _isQuestionReady.value = false;
    _didAnswer.value = false;
    _session.value = Session(
        userEmail: '',
        answers: [],
        numCorrectAnswers: 0,
        numAnswers: 0,
        totalSeconds: 0,
        avgLevel: 0);
    _isSessionActive.value = false;
    _answerSeconds.value = 0;
  }

  Future<Question?> getQuestion() async {
    if (!isSessionActive) {
      print('session is not active');
      return null;
    }

    if (isQuestionReady) _isQuestionReady.value = false;

    Question question = await _questionUseCase.getQuestion(level);
    _question.value = question;
    _isQuestionReady.value = true;

    return question;
  }

  Future<bool> nextQuestion() async {
    if (!isSessionActive) return false;

    if (session.answers.length >= questionsPerSession) {
      // finishSession();
      _isQuestionReady.value = false;
      return false;
    } else {
      await getQuestion();

      // if (!isQuestionReady) _isQuestionReady.value = true;
      if (didAnswer) _didAnswer.value = false;
      return true;
    }
  }

  int performOperation() {
    switch (question.op) {
      case '+':
        return question.num1 + question.num2;
      case '-':
        return question.num1 - question.num2;
      case '*':
        return question.num1 * question.num2;
      case '/':
        return question.num1 ~/ question.num2;
      default:
        return 0;
    }
  }

  void typeNumber(int number) {
    if (!isSessionActive || !isQuestionReady) {
      print('session is not active or question is not ready');
      return;
    }

    String answerString = userAnswer.toString() + number.toString();
    _userAnswer.value = int.parse(answerString);
  }

  void clearAnswer() {
    if (!isSessionActive || !isQuestionReady) {
      print('session is not active or question is not ready');
      return;
    }

    _userAnswer.value = 0;
  }

  Answer? answer(int seconds) {
    if (!isSessionActive || !isQuestionReady) {
      print('session is not active or question is not ready');
      return null;
    }

    _didAnswer.value = true;

    Answer newAnswer = Answer(
        userAnswer: userAnswer,
        isCorrect: userAnswer == performOperation(),
        question: question,
        userEmail: session.userEmail,
        seconds: seconds);

    _level.value = getNewLevel();
    print('newLevel $level');

    _session.value.answers.add(newAnswer);
    _session.value.numAnswers++;
    _session.value.numCorrectAnswers += newAnswer.isCorrect ? 1 : 0;
    _session.value.totalSeconds += seconds;
    _session.value.avgLevel += level;
    if (session.numAnswers == questionsPerSession) {
      _session.value.avgLevel ~/= questionsPerSession;
    }

    return newAnswer;
  }

  int getNewLevel() {
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

  void setAnswerSeconds(int answerSeconds) {
    if (!isSessionActive || !isQuestionReady) {
      print('session is not active or question is not ready');
      return;
    }
    _answerSeconds.value = answerSeconds;
  }
}
