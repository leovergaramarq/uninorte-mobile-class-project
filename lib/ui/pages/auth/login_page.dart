import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uninorte_mobile_class_project/ui/pages/content/home.dart';
import 'package:uninorte_mobile_class_project/ui/pages/content/quest_page.dart';
import 'package:uninorte_mobile_class_project/ui/pages/auth/signup_page.dart';

import 'package:uninorte_mobile_class_project/ui/controller/auth_controller.dart';

import 'package:uninorte_mobile_class_project/domain/models/user.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  String email = '';
  String password = '';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login with email",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: const Key('TextFormFieldLoginEmail'),
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (value) {
                    _emailController.text = value.trim();
                    _emailController.selection = TextSelection.fromPosition(
                        TextPosition(offset: _emailController.text.length));
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter email";
                    } else if (!RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    ).hasMatch(value.trim())) {
                      return "Enter valid email address";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: const Key('TextFormFieldLoginPassword'),
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: "Password"),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter password";
                    } else if (value.length < 6) {
                      return "Password should have at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                    key: const Key('ButtonLoginSubmit'),
                    onPressed: () async {
                      // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                      FocusScope.of(context).requestFocus(FocusNode());
                      final form = _formKey.currentState;
                      form!.save();

                      if (form.validate()) {
                        try {
                          await _authController.login(
                              _emailController.text, _passwordController.text);
                        } catch (e) {
                          print(e);
                        }

                        if (_authController.logged.value) {
                          Get.to(HomePage(
                            key: const Key('HomePage'),
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('User or password not ok'),
                          ));
                        }
                      }
                      // Get.to(const Quest(
                      //   key: Key('Quest'),
                      //   currentLevel: 1,
                      // ));
                    },
                    child: const Text("Submit")),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    key: const Key('ButtonLoginCreateAccount'),
                    onPressed: () => Get.to(const SignUpPage(
                          key: Key('SignUpPage'),
                        )),
                    child: const Text('Create account'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
