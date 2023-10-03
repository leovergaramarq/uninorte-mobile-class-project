class Question {
  Question(this.num1, this.op, this.num2);

  Question.defaultQuestion()
      : num1 = 0,
        op = Operation.none,
        num2 = 0;

  int num1;
  int num2;
  Operation op;

  int get level {
    return (num1.toString().length + num2.toString().length) ~/ 2;
  }

  String get opString {
    switch (op) {
      case Operation.add:
        return '+';
      case Operation.sub:
        return '-';
      case Operation.mul:
        return 'x';
      case Operation.div:
        return '÷';
      default:
        return '?';
    }
  }

  int getAnswer() {
    switch (op) {
      case Operation.add:
        return num1 + num2;
      case Operation.sub:
        return num1 - num2;
      case Operation.mul:
        return num1 * num2;
      case Operation.div:
        return num1 ~/ num2;
      default:
        return 0;
    }
  }

  @override
  String toString() {
    return "$num1 $opString $num2";
  }
}

enum Operation { add, sub, mul, div, none }
