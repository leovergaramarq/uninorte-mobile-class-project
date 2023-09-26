import 'package:uninorte_mobile_class_project/domain/models/question.dart';
import 'package:uninorte_mobile_class_project/domain/repositories/question_repository.dart';

class QuestionUseCase {
  final QuestionRepository repository = QuestionRepository();

  Future<Question> getNextQuestion(int levelOrder, int questionOrder) async {
    print('questions');
    List<List<Question>> questions;
    try {
      questions = await repository.getQuestions();
    } catch (e) {
      print(e);
      return Question(0, '+', 0);
    }
    print('asdhasd');
    List<Question> level = questions[levelOrder % questions.length];
    return level[questionOrder % level.length];
  }
}
