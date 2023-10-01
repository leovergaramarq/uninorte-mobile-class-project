import 'package:uninorte_mobile_class_project/data/datasources/local/question_datasource.dart';
import 'package:uninorte_mobile_class_project/domain/models/question.dart';

class QuestionRepository {
  final QuestionDatasource _questionDatasource = QuestionDatasource();

  Future<Question> getQuestion(int level) async =>
      _questionDatasource.getQuestion(level);
}
