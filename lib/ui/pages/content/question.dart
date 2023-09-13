import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  Question(this.num1, this.op, this.num2);

  int num1;
  int num2;
  String op;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        num1.toString(),
        style: TextStyle(fontSize: 64),
      ),
      SizedBox(width: 16),
      Text(
        op,
        style: TextStyle(fontSize: 64, color: Colors.purple),
      ),
      SizedBox(width: 16),
      Text(
        num2.toString(),
        style: TextStyle(fontSize: 64),
      )
    ]));
  }
}
