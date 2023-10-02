import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/ui/pages/content/session_summary_page.dart';

import 'package:uninorte_mobile_class_project/ui/widgets/answer_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/app_bar_widget.dart';
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
    nextQuestion().catchError((e) {
      print(e);
    });
    if (_authController.isLoggedIn) {
      _questionController.listenLevel((level) async {
        if (level == _userController.user.level) return;
        print('Updating level from ${_userController.user.level} to $level');
        try {
          await _userController.updatePartialUser(level: level);
        } catch (e) {
          print(e);
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    print('dispose');
    answerTimer.cancel();
    _questionController.endSession();
    super.dispose();
  }

  Future<void> nextQuestion() async {
    if (_questionController.userAnswer != 0) _questionController.clearAnswer();
    bool nextQuestionObtained = await _questionController.nextQuestion();

    if (nextQuestionObtained) {
      if (answerTimer.isActive) answerTimer.cancel();
      _questionController.setAnswerSeconds(0);

      answerTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _questionController.setAnswerSeconds(timer.tick);
      });
    } else {
      // There aren't more questions
      _questionController.wrapSessionUp();
      if (_authController.isLoggedIn) {
        // try {
        //   await _sessionController.addSession(_questionController.session);
        // } catch (e) {
        //   print(e);
        // }
        _sessionController
            .addSession(_questionController.session)
            .catchError((e) {
          print(e);
        });
      }
      Get.off(() => SessionSummaryPage(
            key: Key('SessionSummaryPage'),
          ));
    }
  }

  Future<void> changeQuestion() async {
    if (!_questionController.didAnswer) await nextQuestion();
  }

  Widget OptionalContinueWidget() {
    return Obx(() {
      if (_questionController.didAnswer) {
        return Column(
          children: [
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: nextQuestion,
              child: Text('Next', style: TextStyle(fontSize: 20)),
            )
          ],
        );
      } else {
        return Container(
          height: 20,
        );
      }
    });
  }

  Widget QuestionOrLoadWidget() {
    return Obx(() {
      if (_questionController.isQuestionReady) {
        return QuestionWidget(question: _questionController.question);
      } else {
        return const CircularProgressIndicator();
      }
    });
  }

  void typeNumber(int number) {
    if (_questionController.didAnswer ||
        _questionController.userAnswer.toString().length >=
            _questionController.maxLevel + 1) return;
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
          content: Text(newAnswer.isCorrect ? 'Correct!' : 'Incorrect'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error when answering the question'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future<bool>(() async =>
            await showDialog<bool>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Text("Are you sure?"),
                      content: Text(
                          "If you go back, the current session will not be saved."),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            // result = false;
                            Navigator.of(context).pop(false);
                          },
                        ),
                        TextButton(
                          child: Text("Continue"),
                          onPressed: () {
                            // result = true;
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    )) ??
            false);
      },
      child: Scaffold(
        backgroundColor: Color(0xF2F2F2).withOpacity(1),
        key: _scaffoldKey,
        appBar: AppBarWidget(
          text: 'Exercise',
          backButton: true,
          logoutButton: false,
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(
                            'Question ${_questionController.session.answers.length + 1}/${_questionController.questionsPerSession}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )),
                      Row(
                        children: [
                          Text(
                            'Level:',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          Obx(() => LevelStarsWidget(
                                level: min(_questionController.level,
                                    _questionController.maxLevel),
                              )),
                        ],
                      ),
                      Obx(() => Text(
                            'Time: ${Answer.formatTime(_questionController.answerSeconds)}',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                  QuestionOrLoadWidget(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 300, 0),
                        child: Text(
                          '=',
                          style: TextStyle(fontSize: 56),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(300, 0, 0, 0),
                        child: Obx(() {
                          if (_questionController.didAnswer) {
                            if (_questionController.isLastAnswerCorrect()) {
                              return Icon(Icons.check,
                                  size: 56, color: Colors.green.shade600);
                            } else {
                              return Icon(Icons.close,
                                  size: 56, color: Colors.red.shade600);
                            }
                          } else {
                            return Container();
                          }
                        }),
                      ),
                      Container(
                          width: 256,
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(width: 3, color: Colors.black),
                          )),
                          child: Center(
                            child: Obx(() => SingleChildScrollView(
                                  child: AnswerWidget(
                                      _questionController.userAnswer),
                                  scrollDirection: Axis.horizontal,
                                )),
                          )),
                    ],
                  ),
                  // Stack(
                  //   alignment: Alignment.center,
                  //   children: [
                  //     Positioned(
                  //       left: 0,
                  //       child: Text('=asd'),
                  //     ),
                  //     Obx(() => AnswerWidget(_questionController.userAnswer)),
                  //     // Text(
                  //     //   '=',
                  //     //   style: TextStyle(fontSize: 56),
                  //     // ),
                  //   ],
                  // ),
                  NumpadWidget(
                    typeNumber: typeNumber,
                    clearAnswer: clearAnswer,
                    answer: answer,
                  ),
                  OptionalContinueWidget(),
                ],
              ),
            ),
            Align(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 36, 24, 0),
                child: IconButton(
                    onPressed: changeQuestion,
                    icon: const Icon(
                      Icons.refresh,
                      size: 56,
                      color: Colors.purple,
                    )),
              ),
              alignment: Alignment.topRight,
            )
          ],
        ),
      ),
    );
  }
}
