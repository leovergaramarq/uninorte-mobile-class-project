class Question {
  Question(this.num1, this.op, this.num2);

  int num1;
  int num2;
  String op;

  int get level {
    return (num1.toString().length + num2.toString().length) ~/ 2;
  }

  @override
  String toString() {
    return "$num1 $op $num2";
  }
}
