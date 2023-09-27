import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:uninorte_mobile_class_project/ui/pages/content/home.dart';
import 'package:uninorte_mobile_class_project/ui/pages/auth/login_page.dart';

import 'package:uninorte_mobile_class_project/ui/controller/auth_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final AuthController _authController = initAuthController();

  void onSubmit() async {
    // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
    FocusScope.of(context).requestFocus(FocusNode());
    final FormState? form = _formKey.currentState;
    form!.save();

    if (!form.validate()) return;

    bool result;

    try {
      result = await _authController.signUp(
          _emailController.text.trim(), _passwordController.text);
    } catch (e) {
      result = false;
      print(e);
    }

    if (result) {
      if (_authController.logged.value) {
        Get.off(HomePage(
          key: const Key('HomePage'),
        ));
      } else {
        Get.off(LoginPage(
          key: const Key('loginPage'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('User or password not ok'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // Capa 1: Imagen de fondo
            Image.asset(
              'assets/Seconbg.png', // Reemplaza con la ruta de tu imagen de fondo
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),

            // Capa 2: Contenido en el centro
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sum+',
                      style: TextStyle(
                        fontFamily: 'Itim',
                        fontSize: 64,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Please fill the form to create an account",
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      key: const Key('TextFormFieldSignUpEmail'),
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      // onChanged: (value) {
                      //   _emailController.text = value.trim();
                      //   _emailController.selection = TextSelection.fromPosition(
                      //       TextPosition(offset: _emailController.text.length));
                      // },
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
                      key: const Key('TextFormFieldSignUpPassword'),
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
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextFormField(
                        key: const Key('TextFormFieldSignUpBirthdate'),
                        controller: _dateController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today_rounded),
                          labelText: "Birthdate",
                        ),
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2050));
                          if (pickeddate != null) {
                            _dateController.text =
                                DateFormat('yyyy-MM-dd').format(pickeddate);
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      key: const Key('TextFormFieldSignUpSchool'),
                      controller: _schoolController,
                      decoration: const InputDecoration(labelText: "School"),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter school";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      key: const Key('TextFormFieldSignUpGrade'),
                      controller: _gradeController,
                      decoration: const InputDecoration(labelText: "Grade"),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter grade";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                        key: const Key('ButtonSignUpSubmit'),
                        onPressed: onSubmit,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 166, 137, 204),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          minimumSize: Size(100, 40),
                        ),
                        child: const Text("Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontSize: 15,
                            ))),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

AuthController initAuthController() {
  return Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put<AuthController>(AuthController());
}
