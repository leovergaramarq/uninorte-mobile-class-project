import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/ui/pages/auth/first_page.dart';

import 'package:uninorte_mobile_class_project/ui/controller/auth_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/question_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/session_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/user_controller.dart';

import 'package:uninorte_mobile_class_project/domain/repositories/auth_repository.dart';
import 'package:uninorte_mobile_class_project/domain/repositories/question_repository.dart';
import 'package:uninorte_mobile_class_project/domain/repositories/session_repository.dart';
import 'package:uninorte_mobile_class_project/domain/repositories/user_repository.dart';

void main() {
  Get.put<AuthController>(AuthController());
  Get.put<SessionController>(SessionController());
  Get.put<UserController>(UserController());
  Get.put<QuestionController>(QuestionController());

  Get.put<AuthRepository>(AuthRepository());
  Get.put<SessionRepository>(SessionRepository());
  Get.put<UserRepository>(UserRepository());
  Get.put<QuestionRepository>(QuestionRepository());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Summarizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const FirstPage(
        key: Key('FirstPage'),
      ),
    );
  }
}
