import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/ui/pages/auth/login_page.dart';
import 'package:uninorte_mobile_class_project/ui/pages/content/quest_page.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/app_bar_widget.dart';

import 'package:uninorte_mobile_class_project/ui/widgets/level_stars_widget.dart';

import 'package:uninorte_mobile_class_project/ui/controller/auth_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/question_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final AuthController _authController = Get.find<AuthController>();
  final QuestionController _questionController = Get.find<QuestionController>();

  void onLogout() async {
    await _authController.logOut();
    Get.off(() => LoginPage(
          key: const Key('LoginPage'),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBarWidget(text: 'Home', logoutButton: true, onLogout: onLogout),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Set the initial selected index
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue,
        onTap: (int index) {
          // Handle navigation here
        },
      ),
    );
  }
}
