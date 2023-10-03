import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/ui/controller/auth_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/user_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/session_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/question_controller.dart';

import 'package:uninorte_mobile_class_project/ui/pages/auth/login_page.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBarWidget(
      {Key? key,
      this.text = '',
      this.backButton = false,
      this.logoutButton = false})
      : super(key: key);

  final AuthController _authController = Get.find<AuthController>();
  final UserController _userController = Get.find<UserController>();
  final SessionController _sessionController = Get.find<SessionController>();
  final QuestionController _questionController = Get.find<QuestionController>();

  final String text;
  final bool backButton;
  final bool logoutButton;

  void onLogout() {
    _authController.logOut();
    if (_userController.isUserFetched) {
      _userController.resetUser();
    }
    if (_sessionController.areSessionsFetched) {
      _sessionController.resetSessions();
    }
    _questionController.resetLevel();
    Get.off(() => LoginPage(
          key: const Key('LoginPage'),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text),
      centerTitle: true,
      actions: [
        if (logoutButton)
          IconButton(
              key: const Key('ButtonHomeLogOff'),
              onPressed: onLogout,
              icon: const Icon(Icons.logout))
      ],
      automaticallyImplyLeading: backButton,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
