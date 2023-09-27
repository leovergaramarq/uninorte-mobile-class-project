import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/ui/widgets/answer_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/question_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/numpad_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/level_stars_widget.dart';

// import 'package:uninorte_mobile_class_project/domain/models/question.dart'
//     as QuestionModel;
import 'package:uninorte_mobile_class_project/ui/controller/question_controller.dart';

class QuestPage extends StatelessWidget {
  QuestPage({Key? key}) : super(key: key);

  final QuestionController _questionController = initQuestionController();

  void nextQuestion() {
    if (_questionController.answer != 0) _questionController.clearAnswer();
    _questionController.nextQuestion();
    print(_questionController.question);
  }

  Widget OptionalContinueWidget() {
    if (_questionController.answeredCorrect) {
      return Column(
        children: [
          SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: nextQuestion,
            child: Text('Siguiente', style: TextStyle(fontSize: 20)),
          )
        ],
      );
    } else {
      return Container();
    }
  }

  Widget QuestionOrLoadWidget() {
    if (_questionController.areQuestionsFetched) {
      return QuestionWidget(question: _questionController.question);
    } else {
      return const CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    void typeNumber(int number) {
      _questionController.typeNumber(number);
    }

    void clearAnswer() {
      _questionController.clearAnswer();
    }

    void evalAnswer() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_questionController.isAnswerCorrect()
            ? 'Correcto!'
            : 'Incorrecto!'),
      ));
    }

    _questionController.getQuestions();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nivel:'),
            SizedBox(width: 8),
            Obx(() =>
                LevelStarsWidget(level: _questionController.levelIndex + 1)),
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
            Obx(QuestionOrLoadWidget),
            // QuestionOrLoadWidget(),
            SizedBox(
              height: 32,
            ),
            Obx(() => AnswerWidget(_questionController.answer)),
            SizedBox(
              height: 12,
            ),
            NumpadWidget(
              typeNumber: typeNumber,
              clearAnswer: clearAnswer,
              evalAnswer: evalAnswer,
            ),
            Obx(OptionalContinueWidget),
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
