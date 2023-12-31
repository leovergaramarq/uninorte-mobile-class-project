import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/ui/pages/auth/login_page.dart';
import 'package:uninorte_mobile_class_project/ui/pages/content/home_page.dart';

import 'package:uninorte_mobile_class_project/ui/controller/auth_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/user_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/session_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/question_controller.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final AuthController _authController = Get.find<AuthController>();
  final UserController _userController = Get.find<UserController>();
  final SessionController _sessionController = Get.find<SessionController>();
  final QuestionController _questionController = Get.find<QuestionController>();

  void onStart() async {
    if (_authController.isLoggedIn && _userController.isUserFetched) {
      _questionController.setLevel(_userController.user.level!);
      Get.off(
        () => HomePage(
          key: const Key('HomePage'),
        ),
      );
    } else {
      try {
        await Future.wait([
          if (_authController.isLoggedIn) _authController.logOut(),
          if (_userController.isUserFetched) _userController.resetUser(),
          if (_sessionController.areSessionsFetched)
            _sessionController.resetSessions(),
        ]);
      } catch (e) {
        print(e);
      }
      _questionController.resetLevel();
      Get.to(
        () => const LoginPage(
          key: Key('LoginPage'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF2F2F2).withOpacity(1),
      body: Stack(
        children: [
          Image.asset(
            'assets/First.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sum+',
                  style: TextStyle(
                    fontFamily: 'Itim',
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  key: const Key('LoginButton'),
                  onPressed: onStart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF997AC1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    minimumSize: Size(200, 40),
                  ),
                  child: const Text(
                    'Let\'s start!',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
