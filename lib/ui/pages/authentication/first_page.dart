import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signup_page.dart';
import 'login_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Summarizer',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Get.to(const LoginScreen(
                  key: Key('loginPage'),
                  email: "blank",
                  password: "blank",
                ));
              },
              child: const Text('¡Empecemos!'),
            ),
          ],
        ),
      ),
    );
  }
}
