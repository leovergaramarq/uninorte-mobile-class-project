class QuestionDatasource {
  List<List<Question>> getQuestions() {
    return QUESTIONS;
  }
}

final List<List<Question>> QUESTIONS = [
  [
    Question(3, "+", 1),
    Question(3, "*", 7),
    Question(5, "+", 2),
    Question(8, "-", 4),
    Question(6, "*", 3),
    Question(9, "+", 2),
    Question(4, "-", 3),
    Question(2, "+", 1),
    Question(7, "*", 2),
    Question(8, "+", 3),
  ],
  [
    Question(44, "-", 14),
    Question(23, "+", 79),
    Question(65, "-", 42),
    Question(37, "+", 18),
    Question(86, "-", 23),
    Question(55, "+", 12),
    Question(49, "-", 37),
    Question(68, "+", 51),
    Question(72, "-", 29),
    Question(81, "+", 46),
  ],
  [
    Question(123, "-", 56),
    Question(345, "+", 178),
    Question(234, "-", 89),
    Question(567, "+", 234),
    Question(456, "-", 123),
    Question(789, "+", 345),
    Question(678, "-", 456),
    Question(901, "+", 123),
    Question(890, "-", 567),
    Question(432, "+", 345),
  ],
  [
    Question(1234, "-", 567),
    Question(2345, "+", 678),
    Question(3456, "-", 789),
    Question(4567, "+", 890),
    Question(5678, "-", 901),
    Question(6789, "+", 1234),
    Question(7890, "-", 2345),
    Question(8901, "+", 3456),
    Question(9012, "-", 4567),
    Question(1234, "+", 5678),
  ],
  [
    Question(12345, "-", 6789),
    Question(23456, "+", 7890),
    Question(34567, "-", 8901),
    Question(45678, "+", 9012),
    Question(56789, "-", 12345),
    Question(67890, "+", 23456),
    Question(78901, "-", 34567),
    Question(89012, "+", 45678),
    Question(90123, "-", 56789),
    Question(12345, "+", 67890),
  ]
];

class Question {
  Question(this.num1, this.op, this.num2);

  int num1;
  int num2;
  String op;
}
