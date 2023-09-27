class QuestionDatasource {
  List<List<dynamic>> getQuestions() {
    return QUESTIONS;
  }
}

final List<List<dynamic>> QUESTIONS = [
  [
    {"num1": 3, "num2": 1, "op": "+"},
    {"num1": 3, "num2": 7, "op": "+"},
    {"num1": 5, "num2": 2, "op": "+"},
    {"num1": 8, "num2": 4, "op": "+"},
    {"num1": 6, "num2": 3, "op": "+"},
    {"num1": 9, "num2": 2, "op": "+"},
    {"num1": 4, "num2": 3, "op": "+"},
    {"num1": 2, "num2": 1, "op": "+"},
    {"num1": 7, "num2": 2, "op": "+"},
    {"num1": 8, "num2": 3, "op": "+"}
  ],
  [
    {"num1": 44, "num2": 14, "op": "+"},
    {"num1": 23, "num2": 79, "op": "+"},
    {"num1": 65, "num2": 42, "op": "+"},
    {"num1": 37, "num2": 18, "op": "+"},
    {"num1": 86, "num2": 23, "op": "+"},
    {"num1": 55, "num2": 12, "op": "+"},
    {"num1": 49, "num2": 37, "op": "+"},
    {"num1": 68, "num2": 51, "op": "+"},
    {"num1": 72, "num2": 29, "op": "+"},
    {"num1": 81, "num2": 46, "op": "+"}
  ],
  [
    {"num1": 123, "num2": 56, "op": "+"},
    {"num1": 345, "num2": 178, "op": "+"},
    {"num1": 234, "num2": 89, "op": "+"},
    {"num1": 567, "num2": 234, "op": "+"},
    {"num1": 456, "num2": 123, "op": "+"},
    {"num1": 789, "num2": 345, "op": "+"},
    {"num1": 678, "num2": 456, "op": "+"},
    {"num1": 901, "num2": 123, "op": "+"},
    {"num1": 890, "num2": 567, "op": "+"},
    {"num1": 432, "num2": 345, "op": "+"}
  ],
  [
    {"num1": 1234, "num2": 567, "op": "+"},
    {"num1": 2345, "num2": 678, "op": "+"},
    {"num1": 3456, "num2": 789, "op": "+"},
    {"num1": 4567, "num2": 890, "op": "+"},
    {"num1": 5678, "num2": 901, "op": "+"},
    {"num1": 6789, "num2": 1234, "op": "+"},
    {"num1": 7890, "num2": 2345, "op": "+"},
    {"num1": 8901, "num2": 3456, "op": "+"},
    {"num1": 9012, "num2": 4567, "op": "+"},
    {"num1": 1234, "num2": 5678, "op": "+"}
  ],
  [
    {"num1": 12345, "num2": 6789, "op": "+"},
    {"num1": 23456, "num2": 7890, "op": "+"},
    {"num1": 34567, "num2": 8901, "op": "+"},
    {"num1": 45678, "num2": 9012, "op": "+"},
    {"num1": 56789, "num2": 12345, "op": "+"},
    {"num1": 67890, "num2": 23456, "op": "+"},
    {"num1": 78901, "num2": 34567, "op": "+"},
    {"num1": 89012, "num2": 45678, "op": "+"},
    {"num1": 90123, "num2": 56789, "op": "+"},
    {"num1": 12345, "num2": 67890, "op": "+"}
  ]
];

// final List<List<Question>> QUESTIONS = [
//   [
//     Question(3, "+", 1),
//     Question(3, "*", 7),
//     Question(5, "+", 2),
//     Question(8, "-", 4),
//     Question(6, "*", 3),
//     Question(9, "+", 2),
//     Question(4, "-", 3),
//     Question(2, "+", 1),
//     Question(7, "*", 2),
//     Question(8, "+", 3),
//   ],
//   [
//     Question(44, "-", 14),
//     Question(23, "+", 79),
//     Question(65, "-", 42),
//     Question(37, "+", 18),
//     Question(86, "-", 23),
//     Question(55, "+", 12),
//     Question(49, "-", 37),
//     Question(68, "+", 51),
//     Question(72, "-", 29),
//     Question(81, "+", 46),
//   ],
//   [
//     Question(123, "-", 56),
//     Question(345, "+", 178),
//     Question(234, "-", 89),
//     Question(567, "+", 234),
//     Question(456, "-", 123),
//     Question(789, "+", 345),
//     Question(678, "-", 456),
//     Question(901, "+", 123),
//     Question(890, "-", 567),
//     Question(432, "+", 345),
//   ],
//   [
//     Question(1234, "-", 567),
//     Question(2345, "+", 678),
//     Question(3456, "-", 789),
//     Question(4567, "+", 890),
//     Question(5678, "-", 901),
//     Question(6789, "+", 1234),
//     Question(7890, "-", 2345),
//     Question(8901, "+", 3456),
//     Question(9012, "-", 4567),
//     Question(1234, "+", 5678),
//   ],
//   [
//     Question(12345, "-", 6789),
//     Question(23456, "+", 7890),
//     Question(34567, "-", 8901),
//     Question(45678, "+", 9012),
//     Question(56789, "-", 12345),
//     Question(67890, "+", 23456),
//     Question(78901, "-", 34567),
//     Question(89012, "+", 45678),
//     Question(90123, "-", 56789),
//     Question(12345, "+", 67890),
//   ]
// ];

// class Question {
//   Question(this.num1, this.op, this.num2);

//   int num1;
//   int num2;
//   String op;
// }
