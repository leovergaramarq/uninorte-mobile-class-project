import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'package:uninorte_mobile_class_project/domain/models/question.dart';
import 'package:uninorte_mobile_class_project/domain/use_case/question_use_case.dart';

class QuestionController extends GetxController {
  final QuestionUseCase _questionUseCase = initQuestionUseCase();
  final RxInt _levelIndex = 0.obs;
  final RxInt _questionIndex = 0.obs;
  // int levelIndex = 0;
  // int questionIndex = 0;
  final RxInt _answer = 0.obs;
  // final Rx<Question> _question = Rx<Question>(Question(0, '', 0));
  final Rx<List<List<Question>>> _questions = Rx<List<List<Question>>>([]);
  final RxBool _areQuestionsFetched = false.obs;
  final RxBool _answeredCorrect = false.obs;

  int get levelIndex => _levelIndex.value;
  int get questionIndex => _questionIndex.value;
  int get answer => _answer.value;
  Question get question => _questions.value[levelIndex][questionIndex];
  List<List<Question>> get questions => _questions.value;
  bool get areQuestionsFetched => _areQuestionsFetched.value;
  bool get answeredCorrect => _answeredCorrect.value;

  // void nextLevel() {
  //   _levelIndex.value++;
  //   _questionIndex.value = 0;
  // }

  // void nextQuestion() {
  //   _questionIndex.value++;
  // }

  void typeNumber(int number) {
    print('typed number');
    if (!_areQuestionsFetched.value) return;

    String ansString = answer.toString() + number.toString();
    _answer.value = int.parse(ansString);
    print(_answer.value);
  }

  void clearAnswer() {
    if (!_areQuestionsFetched.value) return;
    _answer.value = 0;
  }

  void getQuestions() {
    _questions.value = _questionUseCase.getQuestions();
    if (!_areQuestionsFetched.value) {
      _areQuestionsFetched.value = true;
    }
    if (_answeredCorrect.value) {
      _answeredCorrect.value = false;
    }
  }

  void nextQuestion() {
    if (_areQuestionsFetched.value) {
      _questionIndex.value++;
      if (_questionIndex.value >= _questions.value[levelIndex].length) {
        _questionIndex.value = 0;
        _levelIndex.value++;
        if (_levelIndex.value >= _questions.value.length) {
          _levelIndex.value = 0;
        }
      }
      if (_answeredCorrect.value) {
        _answeredCorrect.value = false;
      }
    }
    // _questions.value = _questions.value.map((e) => e).toList();
    _questions.refresh();
  }

  bool isAnswerCorrect() {
    if (!_areQuestionsFetched.value) return false;

    // Question question = _questions.value[levelIndex][questionIndex];
    int result;

    switch (question.op) {
      case '+':
        result = question.num1 + question.num2;
        break;
      case '-':
        result = question.num1 - question.num2;
        break;
      case '*':
        result = question.num1 * question.num2;
        break;
      case '/':
        result = question.num1 ~/ question.num2;
        break;
      default:
        result = 0;
    }

    _answeredCorrect.value = result == _answer.value;
    return _answeredCorrect.value;
  }
}

QuestionUseCase initQuestionUseCase() {
  return Get.isRegistered<QuestionUseCase>()
      ? Get.find<QuestionUseCase>()
      : Get.put<QuestionUseCase>(QuestionUseCase());
}
