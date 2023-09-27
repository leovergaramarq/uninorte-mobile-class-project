import 'package:flutter/material.dart';

class AnswerInputWidget extends StatelessWidget {
  AnswerInputWidget(this.input);

  String input;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      input,
      style: TextStyle(
        fontSize: 64,
        color: Colors.black,
      ),
    ));
  }
}
