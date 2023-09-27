import 'package:flutter/material.dart';

class AnswerInput extends StatelessWidget {
  AnswerInput(this.input);

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
