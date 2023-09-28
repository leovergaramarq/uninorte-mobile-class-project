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
  final QuestionUseCase _questionUseCase = initQuestionUseCase();
  // final RxInt _levelIndex = 0.obs;
  // final RxInt _questionIndex = 0.obs;
  final RxInt _level = 1.obs;
  final RxInt _userAnswer = 0.obs;
  // final Rx<Question> _question = Rx<Question>(Question(0, '', 0));
  final Rx<List<List<Question>>> _questions = Rx<List<List<Question>>>([]);
  final Rx<Question> _question = Rx<Question>(Question(0, '', 0));
  final RxBool _isQuestionReady = false.obs;
  final RxBool _areQuestionsFetched = false.obs;
  final RxBool _didAnswer = false.obs;
  final Rx<Session> _session = Rx<Session>(Session(
      userEmail: '',
      answers: [],
      numCorrectAnswers: 0,
      numAnswers: 0,
      totalSeconds: 0));
  final RxBool _isSessionActive = false.obs;
  final _answerSeconds = 0.obs;

  // getters
  // int get levelIndex => _levelIndex.value;
  // int get questionIndex => _questionIndex.value;
  int get level => _level.value;
  int get userAnswer => _userAnswer.value;
  Question get question => _question.value;
  List<List<Question>> get questions => _questions.value;
  bool get isQuestionReady => _isQuestionReady.value;
  bool get areQuestionsFetched => _areQuestionsFetched.value;
  bool get didAnswer => _didAnswer.value;
  Session get session => _session.value;
  bool get isSessionActive => _isSessionActive.value;
  int get answerSeconds => _answerSeconds.value;

  Future<void> startSession(String userEmail) async {
    if (userEmail.isEmpty) {
      print('email is empty');
    }
    await fetchQuestions();
    _session.value = Session(
        userEmail: userEmail,
        answers: [],
        numCorrectAnswers: 0,
        numAnswers: 0,
        totalSeconds: 0);
    _isSessionActive.value = true;
  }

  void finishSession() {
    // _session.value.numAnswers = _session.value.answers.length;
    // _session.value.numCorrectAnswers =
    //     _session.value.answers.where((answer) => answer.isCorrect).length;
    // _session.value.totalSeconds = _session.value.answers
    //     .map((answer) => answer.seconds)
    //     .reduce((value, element) => value + element);

    // _levelIndex.value = 0;
    // _questionIndex.value = 0;
    // _level.value = 1;
    _userAnswer.value = 0;
    _questions.value = [];
    _question.value = Question(0, '', 0);
    _isQuestionReady.value = false;
    _areQuestionsFetched.value = false;
    _didAnswer.value = false;
    _session.value = Session(
        userEmail: '',
        answers: [],
        numCorrectAnswers: 0,
        numAnswers: 0,
        totalSeconds: 0);
    _isSessionActive.value = false;
    _answerSeconds.value = 0;
  }

  Question genQuestion() {
    Random random = Random();

    // Calculate the range for random numbers based on the number of digits
    int minRange = pow(10, _level.value - 1).toInt();
    int maxRange = pow(10, _level.value).toInt() - 1;

    // Generate random numbers within the specified range
    int num1 = minRange + random.nextInt(maxRange - minRange);
    int num2 = minRange + random.nextInt(maxRange - minRange);

    return Question(num1, '+', num2);
  }

  Future<void> fetchQuestions() async {
    if (_areQuestionsFetched.value) _areQuestionsFetched.value = false;
    _questions.value = await _questionUseCase.getQuestions();
    _areQuestionsFetched.value = true;
  }

  bool nextQuestion() {
    if (_isSessionActive.value && _areQuestionsFetched.value) {
      // if (!_isQuestionReady.value) {
      //   _questionIndex.value = 0;
      //   _levelIndex.value = 0;
      // } else {
      //   _questionIndex.value++;
      //   if (_questionIndex.value >= _questions.value[levelIndex].length) {
      //     _questionIndex.value = 0;
      //     _levelIndex.value++;
      //     if (_levelIndex.value >= _questions.value.length) {
      //       _levelIndex.value = 0;
      //     }
      //   }
      // }
      // _question.value = _questions.value[levelIndex][questionIndex];
      if (_session.value.answers.length >= questionsPerSession) {
        // finishSession();
        _isQuestionReady.value = false;
        return false;
      } else {
        _question.value = genQuestion();

        if (!_isQuestionReady.value) _isQuestionReady.value = true;
        if (_didAnswer.value) _didAnswer.value = false;
        return true;
      }
    } else {
      return false;
    }
  }

  int performOperation() {
    switch (_question.value.op) {
      case '+':
        return _question.value.num1 + _question.value.num2;
      case '-':
        return _question.value.num1 - _question.value.num2;
      case '*':
        return _question.value.num1 * _question.value.num2;
      case '/':
        return _question.value.num1 ~/ _question.value.num2;
      default:
        return 0;
    }
  }

  void typeNumber(int number) {
    if (!_areQuestionsFetched.value) return;

    String answerString = userAnswer.toString() + number.toString();
    _userAnswer.value = int.parse(answerString);
    // print(_userAnswer.value);
  }

  void clearAnswer() {
    if (!_areQuestionsFetched.value) return;
    _userAnswer.value = 0;
  }

  Answer answer(int seconds) {
    _didAnswer.value = true;

    Answer newAnswer = Answer(
        userAnswer: _userAnswer.value,
        isCorrect: _userAnswer.value == performOperation(),
        question: _question.value,
        userEmail: _session.value.userEmail,
        seconds: seconds);

    _session.value.answers.add(newAnswer);
    _session.value.numAnswers++;
    _session.value.numCorrectAnswers += newAnswer.isCorrect ? 1 : 0;
    _session.value.totalSeconds += seconds;

    _level.value = getNewLevel();
    print('newLevel ${_level.value}');

    return newAnswer;
  }

  int getNewLevel() {
    int boundLevel(int newLevel) {
      return min(max(newLevel, 1), 5);
    }

    List<Answer> answers = _session.value.answers;
    if (answers.length >= minCorrectToLevelUp) {
      List<Answer> lastAnswers = answers
          .getRange(answers.length - minCorrectToLevelUp, answers.length)
          .toList();

      if (!lastAnswers.every(
          (answer) => answer.question.level == lastAnswers[0].question.level)) {
        return boundLevel(_level.value);
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
          return boundLevel(_level.value + 1);
        } else {
          return boundLevel(_level.value);
        }
      } else if (lastAnswers.length - numCorrect >= minWrongToLevelDown) {
        return boundLevel(_level.value - 1);
      } else {
        return boundLevel(_level.value);
      }
    } else {
      return boundLevel(_level.value);
    }
  }

  void setAnswerSeconds(int answerSeconds) {
    _answerSeconds.value = answerSeconds;
  }
}

QuestionUseCase initQuestionUseCase() {
  return Get.isRegistered<QuestionUseCase>()
      ? Get.find<QuestionUseCase>()
      : Get.put<QuestionUseCase>(QuestionUseCase());
}
