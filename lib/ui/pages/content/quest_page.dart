import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/ui/pages/content/answer_input_page.dart';
import 'package:uninorte_mobile_class_project/ui/pages/content/question.dart';
import 'package:uninorte_mobile_class_project/ui/pages/content/numpad.dart';

import 'package:uninorte_mobile_class_project/domain/models/question.dart'
    as QuestionModel;
import 'package:uninorte_mobile_class_project/ui/controller/question_controller.dart';

// class Quest extends StatelessWidget {

//   const Quest({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Sudoku for kids',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: QuestPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class QuestPage extends StatefulWidget {
  const QuestPage({Key? key}) : super(key: key);

  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  final QuestionController _questionController = initQuestionController();

  // @override
  // void initState() {
  //   super.initState();
  // }

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
            levelStars(_questionController.levelIndex + 1),
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
              // future: question,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data;
                } else {
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

QuestionController initQuestionController() {
  return Get.isRegistered<QuestionController>()
      ? Get.find<QuestionController>()
      : Get.put<QuestionController>(QuestionController());
}
