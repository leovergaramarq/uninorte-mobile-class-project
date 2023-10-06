import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uninorte_mobile_class_project/my_app.dart';

import 'package:uninorte_mobile_class_project/ui/controller/auth_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/question_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/session_controller.dart';
import 'package:uninorte_mobile_class_project/ui/controller/user_controller.dart';

// import 'package:uninorte_mobile_class_project/domain/repositories/auth_repository.dart';
// import 'package:uninorte_mobile_class_project/domain/repositories/question_repository.dart';
// import 'package:uninorte_mobile_class_project/domain/repositories/session_repository.dart';
// import 'package:uninorte_mobile_class_project/domain/repositories/user_repository.dart';

// import 'package:uninorte_mobile_class_project/data/repositories/auth_authserver_repository.dart';
// import 'package:uninorte_mobile_class_project/data/repositories/session_retool_repository.dart';
// import 'package:uninorte_mobile_class_project/data/repositories/user_retool_repository.dart';

void main() {
  // Get.put<AuthRepository>(AuthAuthserverRepository());
  // Get.put<SessionRepository>(SessionRetoolRepository());
  // Get.put<UserRepository>(UserRetoolRepository());

  Get.put<AuthController>(AuthController());
  Get.put<SessionController>(SessionController());
  Get.put<UserController>(UserController());
  Get.put<QuestionController>(QuestionController());

  runApp(const MyApp());
}
