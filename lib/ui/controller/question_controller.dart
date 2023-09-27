import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/domain/use_case/question_use_case.dart';

import 'package:uninorte_mobile_class_project/domain/models/question.dart';
import 'package:uninorte_mobile_class_project/domain/models/session.dart';
import 'package:uninorte_mobile_class_project/domain/models/answer.dart';

class QuestionController extends GetxController {
  final QuestionUseCase _questionUseCase = initQuestionUseCase();
  final RxInt _levelIndex = 0.obs;
  final RxInt _questionIndex = 0.obs;
  final RxInt _userAnswer = 0.obs;
  // final Rx<Question> _question = Rx<Question>(Question(0, '', 0));
  final Rx<List<List<Question>>> _questions = Rx<List<List<Question>>>([]);
  final Rx<Question> _question = Rx<Question>(Question(0, '', 0));
  final RxBool _isQuestionReady = false.obs;
  final RxBool _areQuestionsFetched = false.obs;
  final RxBool _didAnswer = false.obs;
  // final RxBool _answeredCorrect = false.obs;
  final Rx<Session> _session = Rx<Session>(Session(
      userEmail: '',
      answers: [],
      level: 0,
      numCorrectAnswers: 0,
      numAnswers: 0,
      totalSeconds: 0));
  final RxBool _isSessionActive = false.obs;
  final _answerSeconds = 0.obs;

  int get levelIndex => _levelIndex.value;
  int get questionIndex => _questionIndex.value;
  int get userAnswer => _userAnswer.value;
  Question get question => _question.value;
  List<List<Question>> get questions => _questions.value;
  bool get isQuestionReady => _isQuestionReady.value;
  bool get areQuestionsFetched => _areQuestionsFetched.value;
  bool get didAnswer => _didAnswer.value;
  // bool get answeredCorrect => _answeredCorrect.value;
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
        level: _levelIndex.value,
        numCorrectAnswers: 0,
        numAnswers: 0,
        totalSeconds: 0);
    _isSessionActive.value = true;
  }

  void finishSession() {
    resetStates();
  }

  Future<void> fetchQuestions() async {
    if (_areQuestionsFetched.value) _areQuestionsFetched.value = false;
    _questions.value = await _questionUseCase.getQuestions();
    _areQuestionsFetched.value = true;
  }

  void nextQuestion() {
    if (_areQuestionsFetched.value) {
      if (!_isQuestionReady.value) {
        _questionIndex.value = 0;
        _levelIndex.value = 0;
      } else {
        _questionIndex.value++;
        if (_questionIndex.value >= _questions.value[levelIndex].length) {
          _questionIndex.value = 0;
          _levelIndex.value++;
          if (_levelIndex.value >= _questions.value.length) {
            _levelIndex.value = 0;
          }
        }
      }
      _question.value = _questions.value[levelIndex][questionIndex];

      if (!_isQuestionReady.value) _isQuestionReady.value = true;
      if (_didAnswer.value) _didAnswer.value = false;
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
    return newAnswer;
  }

  void setAnswerSeconds(int answerSeconds) {
    _answerSeconds.value = answerSeconds;
  }

  void resetStates() {
    _levelIndex.value = 0;
    _questionIndex.value = 0;
    _userAnswer.value = 0;
    _questions.value = [];
    _question.value = Question(0, '', 0);
    _areQuestionsFetched.value = false;
    // _answeredCorrect.value = false;
    _session.value = Session(
        userEmail: '',
        answers: [],
        level: 0,
        numCorrectAnswers: 0,
        numAnswers: 0,
        totalSeconds: 0);
    _isSessionActive.value = false;
  }
}

QuestionUseCase initQuestionUseCase() {
  return Get.isRegistered<QuestionUseCase>()
      ? Get.find<QuestionUseCase>()
      : Get.put<QuestionUseCase>(QuestionUseCase());
}
