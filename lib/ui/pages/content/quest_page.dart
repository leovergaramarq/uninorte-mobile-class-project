import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/ui/widgets/answer_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/question_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/numpad_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/level_stars_widget.dart';

import 'package:uninorte_mobile_class_project/ui/controller/question_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/user_controller.dart';

import 'package:uninorte_mobile_class_project/domain/models/answer.dart';

class QuestPage extends StatefulWidget {
  const QuestPage({Key? key}) : super(key: key);

  @override
  _QuestPageState createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> with WidgetsBindingObserver {
  final QuestionController _questionController = initQuestionController();
  final UserController _userController = initUserController();
  // final Stopwatch stopwatch = Stopwatch();
  // late DateTime dateQuestionLoad;
  Timer answerTimer = Timer(const Duration(), () {});

  void nextQuestion() {
    if (_questionController.userAnswer != 0) _questionController.clearAnswer();
    _questionController.nextQuestion();
    // stopwatch.start();
    // dateQuestionLoad = DateTime.now();

    _questionController.setAnswerSeconds(0);

    if (answerTimer.isActive) answerTimer.cancel();
    answerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _questionController.setAnswerSeconds(timer.tick);
    });
  }

  Widget OptionalContinueWidget() {
    if (_questionController.didAnswer) {
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
  void dispose() {
    // stopwatch.stop();
    // stopwatch.reset();
    print('dispose');
    answerTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void typeNumber(int number) {
      _questionController.typeNumber(number);
    }

    void clearAnswer() {
      _questionController.clearAnswer();
    }

    void answer() {
      if (!_questionController.isQuestionReady) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please wait for the question to load'),
        ));
      } else if (_questionController.didAnswer) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('You already answered this question'),
        ));
      } else {
        // int seconds = DateTime.now().difference(dateQuestionLoad).inSeconds;
        // int seconds = stopwatch.elapsed.inSeconds;
        // stopwatch.stop();
        // stopwatch.reset();
        answerTimer.cancel();

        print('seconds ${_questionController.answerSeconds}');

        Answer newAnswer =
            _questionController.answer(_questionController.answerSeconds);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(newAnswer.isCorrect ? 'Correcto!' : 'Incorrecto!'),
        ));
      }
    }

    // _questionController.getQuestions().catchError(() {});
    _questionController
        .startSession(_userController.userEmail)
        .then((value) => nextQuestion())
        .catchError(() {});

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
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // SizedBox(
                //   height: 12,
                // ),
                Obx(QuestionOrLoadWidget),
                // QuestionOrLoadWidget(),
                // SizedBox(
                //   height: 12,
                // ),
                Obx(() => AnswerWidget(_questionController.userAnswer)),
                // SizedBox(
                //   height: 12,
                // ),
                NumpadWidget(
                  typeNumber: typeNumber,
                  clearAnswer: clearAnswer,
                  answer: answer,
                ),
                Obx(OptionalContinueWidget),
              ],
            ),
          ),
          Row(
            children: [
              Obx(() => Text(
                    'Tiempo: ${_questionController.answerSeconds} s',
                    style: TextStyle(fontSize: 16),
                  )),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          )
        ],
      ),
    );
  }
}

QuestionController initQuestionController() {
  return Get.isRegistered<QuestionController>()
      ? Get.find<QuestionController>()
      : Get.put<QuestionController>(QuestionController());
}

UserController initUserController() {
  return Get.isRegistered<UserController>()
      ? Get.find<UserController>()
      : Get.put<UserController>(UserController());
}
