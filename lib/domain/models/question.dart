class Question {
  Question(this.num1, this.op, this.num2);

  Question.defaultQuestion()
      : num1 = 0,
        op = '',
        num2 = 0;

  int num1;
  int num2;
  String op;

  int get level {
    return (num1.toString().length + num2.toString().length) ~/ 2;
  }

  int getAnswer() {
    switch (op) {
      case '+':
        return num1 + num2;
      case '-':
        return num1 - num2;
      case '*':
        return num1 * num2;
      case '/':
        return num1 ~/ num2;
      default:
        return 0;
    }
  }

  @override
  String toString() {
    return "$num1 $op $num2";
  }
}
