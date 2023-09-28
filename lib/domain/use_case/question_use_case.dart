import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/domain/models/question.dart';
import 'package:uninorte_mobile_class_project/domain/repositories/repository.dart';

class QuestionUseCase {
  final Repository _repository = initRepository();

  Question getQuestion(int levelIndex, int questionIndex) {
    List<List<dynamic>> questionsRaw = _repository.getQuestions();
    List<List<Question>> questions = questionsRaw
        .map((questionList) => questionList
            .map((q) => Question(q["num1"], q["op"], q["num2"]))
            .toList())
        .toList();
    List<Question> level = questions[levelIndex % questions.length];
    return level[questionIndex % level.length];
  }

  Future<List<List<Question>>> getQuestions() async {
    List<List<dynamic>> questionsRaw = _repository.getQuestions();
    return questionsRaw
        .map((questionList) => questionList
            .map((q) => Question(q["num1"], q["op"], q["num2"]))
            .toList())
        .toList();
  }
}

Repository initRepository() {
  return Get.isRegistered<Repository>()
      ? Get.find<Repository>()
      : Get.put<Repository>(Repository());
}
