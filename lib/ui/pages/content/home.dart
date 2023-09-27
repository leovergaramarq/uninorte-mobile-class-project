import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/ui/pages/auth/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // final String loggedEmail;
  // final String loggedPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Suma Pop"),
        actions: [
          IconButton(
              key: const Key('ButtonHomeLogOff'),
              onPressed: () {
                Get.off(() => LoginPage(
                      key: const Key('loginPage'),
                      // email: loggedEmail,
                      // password: loggedPassword,
                    ));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
