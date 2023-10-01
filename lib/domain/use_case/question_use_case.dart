import 'package:uninorte_mobile_class_project/domain/models/question.dart';
import 'package:uninorte_mobile_class_project/domain/repositories/question_repository.dart';

class QuestionUseCase {
  final QuestionRepository _questionRepository = QuestionRepository();

  Future<Question> getQuestion(int level) async =>
      await _questionRepository.getQuestion(level);
}
