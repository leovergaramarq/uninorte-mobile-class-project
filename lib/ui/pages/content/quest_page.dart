import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/ui/widgets/answer_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/question_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/numpad_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/level_stars_widget.dart';

import 'package:uninorte_mobile_class_project/ui/controller/question_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/user_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/auth_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/session_controller.dart';

import 'package:uninorte_mobile_class_project/domain/models/answer.dart';

class QuestPage extends StatefulWidget {
  const QuestPage({Key? key}) : super(key: key);

  @override
  _QuestPageState createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final QuestionController _questionController = Get.find<QuestionController>();
  final AuthController _authController = Get.find<AuthController>();
  final SessionController _sessionController = Get.find<SessionController>();
  final UserController _userController = Get.find<UserController>();
  Timer answerTimer = Timer(const Duration(), () {});

  @override
  void initState() {
    _questionController.startSession(_userController.user.email);
    nextQuestion();
    super.initState();
  }

  @override
  void dispose() {
    print('dispose');
    answerTimer.cancel();
    super.dispose();
  }

  Future<void> nextQuestion() async {
    if (_questionController.userAnswer != 0) _questionController.clearAnswer();
    bool result = await _questionController.nextQuestion();

    if (result) {
      _questionController.setAnswerSeconds(0);

      if (answerTimer.isActive) answerTimer.cancel();
      answerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _questionController.setAnswerSeconds(timer.tick);
      });
    } else {
      _sessionController.addSession(_questionController.session);
    }
  }

  Future<void> changeQuestion() async {
    if (!_questionController.didAnswer) await nextQuestion();
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
    if (_questionController.isQuestionReady) {
      return QuestionWidget(question: _questionController.question);
    } else {
      return const CircularProgressIndicator();
    }
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String formattedTime = '';

    if (hours > 0) {
      formattedTime += '$hours h, ';
    }

    if (minutes > 0 || hours > 0) {
      formattedTime += '$minutes m, ';
    }

    formattedTime += '$remainingSeconds s';

    return formattedTime;
  }

  void typeNumber(int number) {
    if (_questionController.didAnswer) return;
    _questionController.typeNumber(number);
  }

  void clearAnswer() {
    _questionController.clearAnswer();
  }

  void answer() {
    BuildContext context;
    try {
      context = _scaffoldKey.currentContext!;
    } catch (e) {
      print(e);
      return;
    }
    if (!_questionController.isQuestionReady) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please wait for the question to load'),
      ));
    } else if (_questionController.didAnswer) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('You already answered this question'),
      ));
    } else {
      answerTimer.cancel();

      print('seconds ${_questionController.answerSeconds}');

      Answer? newAnswer =
          _questionController.answer(_questionController.answerSeconds);

      if (newAnswer != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(newAnswer.isCorrect ? 'Correcto!' : 'Incorrecto!'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al responder la pregunta'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nivel:'),
            SizedBox(width: 8),
            Obx(() => LevelStarsWidget(level: _questionController.level)),
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
                Obx(QuestionOrLoadWidget),
                Obx(() => AnswerWidget(_questionController.userAnswer)),
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
              Column(
                children: [
                  Obx(() => Text(
                        'Tiempo: ${formatTime(_questionController.answerSeconds)}',
                        style: TextStyle(fontSize: 16),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  IconButton(
                      onPressed: changeQuestion,
                      icon: const Icon(
                        Icons.refresh,
                        size: 40,
                      ))
                ],
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          )
        ],
      ),
    );
  }
}
