import 'dart:math';
import 'package:uninorte_mobile_class_project/domain/models/question.dart';

class QuestionDatasource {
  Future<Question> getQuestion(int level) async {
    Random random = Random();

    // Calculate the range for random numbers based on the number of digits
    int minRange = pow(10, level - 1).toInt();
    int maxRange = pow(10, level).toInt() - 1;

    // Generate random numbers within the specified range
    int num1 = minRange + random.nextInt(maxRange - minRange);
    int num2 = minRange + random.nextInt(maxRange - minRange);

    return Question(num1, '+', num2);
  }
}
