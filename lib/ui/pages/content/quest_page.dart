import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uninorte_mobile_class_project/domain/use_case/question_use_case.dart';
import 'package:uninorte_mobile_class_project/domain/models/question.dart'
    as QuestionModel;
import './numpad.dart';
import './question.dart';
import 'answer_input_page.dart';

class Quest extends StatelessWidget {
  final int currentLevel; // Nivel actual

  const Quest({Key? key, required this.currentLevel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku for kids',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: QuestPage(currentLevel: currentLevel),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuestPage extends StatefulWidget {
  QuestPage({Key? key, required this.currentLevel}) : super(key: key);

  int currentLevel;
  late Future<QuestionModel.Question> question;
  final QuestionUseCase questionUseCase = QuestionUseCase();

  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  @override
  void initState() {
    widget.question = widget.questionUseCase
        .getNextQuestion(widget.currentLevel - 1, Random().nextInt(4));
    super.initState();
  }

  Widget levelStars(int level) {
    return Row(
      children: List.generate(
          level, (index) => Icon(Icons.star, color: Colors.yellow)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nivel:'),
            SizedBox(width: 8),
            levelStars(widget.currentLevel),
          ],
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 32,
            ),
            // Question(3, '+', 3),
            FutureBuilder(
              future: widget.question,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data;
                } else {
                  print(snapshot.data);
                  print(widget.question);
                  return CircularProgressIndicator();
                }
              },
            ),
            SizedBox(
              height: 32,
            ),
            AnswerInput('0'),
            SizedBox(
              height: 12,
            ),
            Numpad()
          ],
        ),
      ),
    );
  }

  // Future<QuestionModel.Question> getQuestion() async {
  //   return await widget.questionUseCase.getNextQuestion(widget.currentLevel, Random().nextInt(4));
  // }

  // Future<Widget> getQuestionWidget() async {
  //   // if (!widget.questionReady) {
  //   //   return Container(child: Text('Loading...'));
  //   // }
  //   question = await questionUseCase
  //       .getNextQuestion(widget.currentLevel - 1, Random().nextInt(4));
  //   print(widget.question);
  //   return Question(
  //       widget.question.num1, widget.question.op, widget.question.num2);
  // }
}
