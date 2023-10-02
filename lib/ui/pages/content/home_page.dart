import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:uninorte_mobile_class_project/ui/pages/auth/login_page.dart';
import 'package:uninorte_mobile_class_project/ui/pages/content/quest_page.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/app_bar_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/bottom_nav_bar_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/level_stars_widget.dart';

import 'package:uninorte_mobile_class_project/ui/controller/auth_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/question_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/user_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/session_controller.dart';

import 'package:uninorte_mobile_class_project/domain/models/answer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, this.fetchSessions = true}) : super(key: key);
  bool fetchSessions;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final AuthController _authController = Get.find<AuthController>();
  final QuestionController _questionController = Get.find<QuestionController>();
  final UserController _userController = Get.find<UserController>();
  final SessionController _sessionController = Get.find<SessionController>();

  @override
  void initState() {
    if (widget.fetchSessions) {
      _sessionController
          .getSessionsFromUser(_userController.user.email,
              limit: _sessionController.numSummarizeSessions)
          .catchError((e) {
        print(e);
      });
    }
    super.initState();
  }

  void onLogout() async {
    await _authController.logOut();
    Get.off(() => LoginPage(
          key: const Key('LoginPage'),
        ));
  }

  Widget SessionsSummaryWidget() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(6, 8, 6, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Last ${_sessionController.numSummarizeSessions} sessions',
                style: const TextStyle(fontSize: 22),
              ),
              SizedBox(height: 16),
              Obx(() {
                // print(
                //     '_sessionController.areSessionsFetched ${_sessionController.areSessionsFetched}');
                if (!_sessionController.areSessionsFetched) {
                  return const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  );
                }

                int avgSeconds = _sessionController.sessions.fold(
                        0,
                        (previousValue, element) =>
                            previousValue + element.totalSeconds) ~/
                    _sessionController.sessions.length;

                int totalAnswers = _sessionController.sessions.fold(
                    0,
                    (previousValue, element) =>
                        previousValue + element.numAnswers);

                int totalCorrectAnswers = _sessionController.sessions.fold(
                    0,
                    (previousValue, element) =>
                        previousValue + element.numCorrectAnswers);

                int correctPercentage =
                    (totalCorrectAnswers / totalAnswers * 100).round();

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.av_timer,
                          size: 36,
                          color: Color(0x3C3C3C).withOpacity(1),
                        ),
                        Text(
                          'Average time per session: ${Answer.formatTime(avgSeconds)}',
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.task_outlined,
                          size: 36,
                          color: Color(0x3C3C3C).withOpacity(1),
                        ),
                        Text(
                            'Success: $totalCorrectAnswers/$totalAnswers ($correctPercentage%)',
                            style: const TextStyle(fontSize: 18))
                      ],
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                );
              })
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF2F2F2).withOpacity(1),
      appBar:
          AppBarWidget(text: 'Home', logoutButton: true, onLogout: onLogout),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${_userController.user.email}!',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/img/exercise_bg.png', // Reemplaza con la ruta de tu imagen de fondo
                            // width: double.infinity,
                            // height: double.infinity,
                            // fit: BoxFit.cover,
                          ),
                          Obx(() => LevelStarsWidget(
                                level: min(_questionController.level,
                                    _questionController.maxLevel),
                                starSize: 36,
                              ))
                        ],
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => const QuestPage(
                                key: Key('QuestPage'),
                              ));
                        },
                        child: Obx(() => Text(
                            // _sessionController.areSessionsFetched &&
                            _sessionController.sessions.isNotEmpty
                                ? 'Continue'
                                : 'Let\'s go!',
                            style: TextStyle(fontSize: 20))),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 56),
              SessionsSummaryWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          BottomNavBarWidget(section: BottomNavBarWidgetSections.home),
    );
  }
}
