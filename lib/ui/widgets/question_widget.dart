import 'package:flutter/material.dart';

import 'package:uninorte_mobile_class_project/domain/models/question.dart';

class QuestionWidget extends StatelessWidget {
  // QuestionWidget(
  //     {Key? key, required this.num1, required this.op, required this.num2});
  QuestionWidget({Key? key, required this.question});

  // QuestionWidget.fromDynamic({Key? key, required dynamic question}) {
  //   num1 = question['num1'];
  //   num2 = question['num2'];
  //   op = question['op'];
  // }

  // late int num1;
  // late int num2;
  // late String op;
  late Question question;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        question.num1.toString(),
        style: TextStyle(fontSize: 64),
      ),
      SizedBox(width: 16),
      Text(
        question.op,
        style: TextStyle(fontSize: 64, color: Colors.purple),
      ),
      SizedBox(width: 16),
      Text(
        question.num2.toString(),
        style: TextStyle(fontSize: 64),
      )
    ]));
  }
}
