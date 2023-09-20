import 'package:flutter/material.dart';
import './numpad.dart';
import './question.dart';
import 'answer_input_page.dart';

class Quest extends StatelessWidget {
  final int currentLevel; // Nivel actual

  const Quest({Key? key, required this.currentLevel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku for kids',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: QuestPage(currentLevel: currentLevel),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuestPage extends StatefulWidget {
  final int currentLevel;

  const QuestPage({Key? key, required this.currentLevel}) : super(key: key);

  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  Widget levelStars(int level) {
    return Row(
      children: List.generate(
          level, (index) => Icon(Icons.star, color: Colors.yellow)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nivel:'),
            SizedBox(width: 8),
            levelStars(widget.currentLevel),
          ],
        ),
      ),
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
