import 'package:flutter/material.dart';

class AnswerWidget extends StatelessWidget {
  AnswerWidget(this.input);

  int input;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      input.toString(),
      style: TextStyle(
        fontSize: 64,
        color: Colors.black,
      ),
    ));
  }
}
