import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:uninorte_mobile_class_project/ui/pages/auth/signup_page.dart';
import 'package:uninorte_mobile_class_project/ui/pages/auth/login_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
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
                  onPressed: () {
                    Get.to(
                      LoginPage(
                        key: Key('LoginPage'),
                      ),
                    );
                  },
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
