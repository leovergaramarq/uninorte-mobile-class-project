import 'package:flutter/material.dart';
import './numpad.dart';
import './question.dart';
import './answerInput.dart';

class Quest extends StatelessWidget {
  const Quest({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Sudoku for kids',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const QuestPage(),
        debugShowCheckedModeBanner: false);
  }
}

class QuestPage extends StatefulWidget {
  const QuestPage({super.key});

  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 32,
            ),
            Question(3, '+', 3),
            SizedBox(
              height: 32,
            ),
            AnswerInput('0'),
            SizedBox(
              height: 12,
            ),
            Numpad()
          ],
        ),
      ),
    );
  }
}
