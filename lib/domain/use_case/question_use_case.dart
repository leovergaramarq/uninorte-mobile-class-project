import 'package:uninorte_mobile_class_project/domain/models/question.dart';
import 'package:uninorte_mobile_class_project/domain/repositories/repository.dart';

class QuestionUseCase {
  final Repository repository = Repository();

  Future<Question> getNextQuestion(int levelIndex, int questionIndex) async {
    print('questions');
    List<List<Question>> questions;
    try {
      // questions = await repository.getQuestions();
      questions = [];
    } catch (e) {
      print(e);
      return Question(0, '+', 0);
    }
    List<Question> level = questions[levelIndex % questions.length];
    return level[questionIndex % level.length];
  }
}
