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

class SessionSummaryPage extends StatelessWidget {
  SessionSummaryPage({Key? key}) : super(key: key);

  // final AuthController _authController = Get.find<AuthController>();
  final QuestionController _questionController = Get.find<QuestionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF2F2F2).withOpacity(1),
      appBar: AppBarWidget(
        text: 'Results',
        logoutButton: false,
        backButton: true,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 56, 16, 36),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      LevelStarsWidget(
                        level: min(_questionController.level,
                            _questionController.maxLevel),
                        starSize: 96,
                      ),
                      const Text('New level!',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Answers',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      ListView(
                        children: _questionController.session.answers
                            .map((answer) => Container(
                                child: Text(answer.isCorrect.toString())))
                            .toList(),
                      )
                    ],
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade400,
                        foregroundColor: Colors.black87),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Back to menu',
                        style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.off(() => const QuestPage(
                            key: Key('QuestPage'),
                          ));
                    },
                    child:
                        const Text('Try again', style: TextStyle(fontSize: 20)),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
