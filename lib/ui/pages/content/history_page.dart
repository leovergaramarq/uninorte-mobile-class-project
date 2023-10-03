import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:uninorte_mobile_class_project/ui/pages/auth/login_page.dart';
// import 'package:uninorte_mobile_class_project/ui/pages/content/quest_page.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/app_bar_widget.dart';
import 'package:uninorte_mobile_class_project/ui/widgets/bottom_nav_bar_widget.dart';

// import 'package:uninorte_mobile_class_project/ui/widgets/level_stars_widget.dart';

import 'package:uninorte_mobile_class_project/ui/controller/auth_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/user_controller.dart';
// import 'package:uninorte_mobile_class_project/ui/controller/question_controller.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);

  final AuthController _authController = Get.find<AuthController>();
  final UserController _userController = Get.find<UserController>();
  // final QuestionController _questionController = Get.find<QuestionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF2F2F2).withOpacity(1),
      appBar: AppBarWidget(text: 'History', logoutButton: true),
      bottomNavigationBar:
          BottomNavBarWidget(section: BottomNavBarWidgetSections.history),
    );
  }
}
