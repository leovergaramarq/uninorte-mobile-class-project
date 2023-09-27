import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'package:uninorte_mobile_class_project/domain/use_case/question_use_case.dart';

class QuestionController extends GetxController {
  final QuestionUseCase _questionUseCase = initQuestionUseCase();
  final RxInt _levelIndex = 0.obs;
  final RxInt _questionIndex = 0.obs;

  int get levelIndex => _levelIndex.value;
  int get questionIndex => _questionIndex.value;

  void nextLevel() {
    _levelIndex.value++;
    _questionIndex.value = 0;
  }

  void nextQuestion() {
    _questionIndex.value++;
  }

  Future<void> getQuestion() async {
    logInfo('Controller Get Question');
    await _questionUseCase.getNextQuestion(levelIndex, questionIndex);
  }
}

QuestionUseCase initQuestionUseCase() {
  return Get.isRegistered<QuestionUseCase>()
      ? Get.find<QuestionUseCase>()
      : Get.put<QuestionUseCase>(QuestionUseCase());
}
