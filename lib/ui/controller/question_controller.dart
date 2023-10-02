import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/domain/use_case/question_use_case.dart';

import 'package:uninorte_mobile_class_project/domain/models/question.dart';
import 'package:uninorte_mobile_class_project/domain/models/session.dart';
import 'package:uninorte_mobile_class_project/domain/models/answer.dart';

class QuestionController extends GetxController {
  // states
  final QuestionUseCase _questionUseCase = QuestionUseCase();
  final RxInt _level = 1.obs;
  final RxInt _userAnswer = 0.obs;
  final Rx<Question> _question = Rx<Question>(Question.defaultQuestion());
  final RxBool _isQuestionReady = false.obs;
  final RxBool _didAnswer = false.obs;
  final Rx<Session> _session = Rx<Session>(Session.defaultSession());
  final RxBool _isSessionActive = false.obs;
  final _answerSeconds = 0.obs;

  // Getters
  int get level => _level.value;
  int get userAnswer => _userAnswer.value;
  Question get question => _question.value;
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
    _session.value = Session.defaultSession();
    _session.value.userEmail = userEmail;
    _isSessionActive.value = true;
  }

  void finishSession() {
    if (!isSessionActive) {
      print('session is not active');
      return;
    }

    // Wrap session up
    _session.value.wrapUp(level);

    // Reset values
    // _level.value = 1;
    _userAnswer.value = 0;
    _question.value = Question.defaultQuestion();
    _isQuestionReady.value = false;
    _didAnswer.value = false;
    _session.value = Session.defaultSession();
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

    if (_questionUseCase.areAllQuestionsAnswered(session.answers)) {
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

  void typeNumber(int typedNumber) {
    if (!isSessionActive || !isQuestionReady) {
      print('session is not active or question is not ready');
      return;
    }

    _userAnswer.value =
        _questionUseCase.concatTypedNumber(userAnswer, typedNumber);
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
        isCorrect: _questionUseCase.isAnswerCorrect(question, userAnswer),
        question: question,
        userEmail: session.userEmail,
        seconds: seconds);

    _level.value = _questionUseCase.getNewLevel(session, level);
    print('newLevel $level');

    _session.value.answers.add(newAnswer);

    return newAnswer;
  }

  void setAnswerSeconds(int answerSeconds) {
    if (!isSessionActive || !isQuestionReady) {
      print('session is not active or question is not ready');
      return;
    }
    _answerSeconds.value = answerSeconds;
  }
}
