import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/ui/pages/auth/login_page.dart';
import 'package:uninorte_mobile_class_project/ui/pages/content/quest_page.dart';

import 'package:uninorte_mobile_class_project/ui/widgets/level_stars_widget.dart';

import 'package:uninorte_mobile_class_project/ui/controller/auth_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/question_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final AuthController _authController = initAuthController();
  final QuestionController _questionController = initQuestionController();

  void onLogout() async {
    await _authController.logOut();
    Get.off(() => LoginPage(
          key: const Key('LoginPage'),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Suma Pop"),
        actions: [
          IconButton(
              key: const Key('ButtonHomeLogOff'),
              onPressed: onLogout,
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Obx(() => LevelStarsWidget(level: _questionController.level)),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.to(() => QuestPage(
                        key: const Key('QuestPage'),
                      ));
                },
                child: Text('Start quest!', style: TextStyle(fontSize: 20)),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}

AuthController initAuthController() {
  return Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put<AuthController>(AuthController());
}

QuestionController initQuestionController() {
  return Get.isRegistered<QuestionController>()
      ? Get.find<QuestionController>()
      : Get.put<QuestionController>(QuestionController());
}
