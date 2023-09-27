import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui/pages/authentication/first_page.dart';
import 'ui/pages/content/quest_page.dart';

void main() {
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
        key: Key('firstPage'),
      ),
      // home: const Quest(
      //   key: Key('questPage'),
      //   currentLevel: 3,
      // ),
    );
  }
}
