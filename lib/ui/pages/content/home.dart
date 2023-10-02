import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/ui/pages/auth/login_page.dart';
import 'package:uninorte_mobile_class_project/ui/pages/content/quest_page.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/app_bar_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/bottom_nav_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/level_stars_widget.dart';

import 'package:uninorte_mobile_class_project/ui/controller/auth_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/question_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/user_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/session_controller.dart';

import 'package:uninorte_mobile_class_project/domain/models/answer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
    _sessionController
        .getSessionsFromUser(_userController.user.email,
            limit: _sessionController.numSummarizeSessions)
        .catchError((e) {
      print(e);
    });
    super.initState();
  }

  void onLogout() async {
    await _authController.logOut();
    Get.off(() => LoginPage(
          key: const Key('LoginPage'),
        ));
  }

  Widget SessionsSummaryOrLoadWidget() {
    return Obx(() {
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
          0, (previousValue, element) => previousValue + element.numAnswers);

      int totalCorrectAnswers = _sessionController.sessions.fold(
          0,
          (previousValue, element) =>
              previousValue + element.numCorrectAnswers);

      int correctPercentage =
          (totalCorrectAnswers / totalAnswers * 100).round();

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
          ),
          const Text('Here goes the amazing chart')
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF2F2F2).withOpacity(1),
      appBar:
          AppBarWidget(text: 'Home', logoutButton: true, onLogout: onLogout),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            child: Column(
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
                              level: _questionController.level,
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
                      child: const Text('Let\'s go!',
                          style: TextStyle(fontSize: 20)),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 56),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Container(
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
                  SessionsSummaryOrLoadWidget()
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          BottomNavWidget(section: BottomNavWidgetSections.home),
    );
  }
}
