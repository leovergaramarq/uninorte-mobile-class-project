import 'package:flutter/material.dart';

class AnswerTypingWidget extends StatelessWidget {
  AnswerTypingWidget(this.input);

  int input;

  @override
  Widget build(BuildContext context) {
    return Text(
      input.toString(),
      style: TextStyle(
        fontSize: 56,
        color: Colors.black,
      ),
    );
  }
}
