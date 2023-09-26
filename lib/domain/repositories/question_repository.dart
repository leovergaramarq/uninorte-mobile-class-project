import 'dart:convert';
import 'package:uninorte_mobile_class_project/data/datasources/local/models/question_datasource.dart';
import 'package:uninorte_mobile_class_project/domain/models/question.dart';

class QuestionRepository {
  // AuthenticationRepository() {
  //   datasource = QuestionDatasource();
  // }

  final QuestionDatasource datasource = QuestionDatasource();

  Future<List<List<Question>>> getQuestions() async {
    dynamic questions = await datasource.getQuestions();
    print(questions.runtimeType);
    // List<List<Map<String, dynamic>>> questions =
    //     await datasource.getQuestions();
    // questions.map((idk) {
    //   print(idk);
    // });
    return questions.map((level) {
      print(level.runtimeType);
      return level.map((question) {
        print(question.runtimeType);
        print(question.getPropertyValue("num1"));
        // print(jsonDecode(question.toString()) as Map<String, dynamic>);
        return Question(question.num1, question.op, question.num2);
      }).toList();
    }).toList();
  }
}
