import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/ui/widgets/answer_input_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/question_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/numpad_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/level_stars_widget.dart';

// import 'package:uninorte_mobile_class_project/domain/models/question.dart'
//     as QuestionModel;
import 'package:uninorte_mobile_class_project/ui/controller/question_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nivel:'),
            SizedBox(width: 8),
            LevelStarsWidget(level: _questionController.levelIndex + 1),
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
            QuestionWidget(question: _questionController.getQuestion()),
            SizedBox(
              height: 32,
            ),
            AnswerInputWidget('0'),
            SizedBox(
              height: 12,
            ),
            NumpadWidget()
          ],
        ),
      ),
    );
  }
}

QuestionController initQuestionController() {
  return Get.isRegistered<QuestionController>()
      ? Get.find<QuestionController>()
      : Get.put<QuestionController>(QuestionController());
}
