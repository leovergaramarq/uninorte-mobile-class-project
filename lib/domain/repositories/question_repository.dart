import 'package:uninorte_mobile_class_project/data/datasources/local/question_datasource.dart';
import 'package:uninorte_mobile_class_project/domain/models/question.dart';

abstract class QuestionRepository {
  Future<Question> getQuestion(int level);
}
