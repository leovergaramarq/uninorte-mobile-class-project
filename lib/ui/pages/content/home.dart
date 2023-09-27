import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/ui/pages/auth/login_page.dart';

import 'package:uninorte_mobile_class_project/ui/controller/auth_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final AuthController _authController = initAuthController();

  void onLogout() async {
    await _authController.logOut();
    Get.off(() => LoginPage(
          key: const Key('loginPage'),
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
    );
  }
}

AuthController initAuthController() {
  return Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put<AuthController>(AuthController());
}
