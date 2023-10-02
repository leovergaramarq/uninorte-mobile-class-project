import 'package:flutter/material.dart';

class NumpadWidget extends StatelessWidget {
  NumpadWidget({
    Key? key,
    required this.typeNumber,
    required this.answer,
    required this.clearAnswer,
  });

  void Function(int) typeNumber;
  VoidCallback clearAnswer;
  VoidCallback answer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                child: const Text(
                  '1',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 32),
                ),
                onPressed: () => typeNumber(1),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(12),
                )),
            SizedBox(width: 36),
            ElevatedButton(
                child: const Text(
                  '2',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 32),
                ),
                onPressed: () => typeNumber(2),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(12),
                )),
            SizedBox(width: 36),
            ElevatedButton(
                child: const Text(
                  '3',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 32),
                ),
                onPressed: () => typeNumber(3),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(12),
                )),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                child: const Text(
                  '4',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 32),
                ),
                onPressed: () => typeNumber(4),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(12),
                )),
            SizedBox(width: 36),
            ElevatedButton(
                child: const Text(
                  '5',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 32),
                ),
                onPressed: () => typeNumber(5),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(12),
                )),
            SizedBox(width: 36),
            ElevatedButton(
                child: const Text(
                  '6',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 32),
                ),
                onPressed: () => typeNumber(6),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(12),
                )),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                child: const Text(
                  '7',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 32),
                ),
                onPressed: () => typeNumber(7),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(12),
                )),
            SizedBox(width: 36),
            ElevatedButton(
                child: const Text(
                  '8',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 32),
                ),
                onPressed: () => typeNumber(8),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(12),
                )),
            SizedBox(width: 36),
            ElevatedButton(
                child: const Text(
                  '9',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 32),
                ),
                onPressed: () => typeNumber(9),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(12),
                )),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                child: const Text('0',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 32)),
                onPressed: () => typeNumber(0),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(12),
                )),
            SizedBox(width: 36),
            ElevatedButton(
                child: const Text('C',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 32)),
                onPressed: clearAnswer,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(12),
                )),
            SizedBox(width: 36),
            ElevatedButton(
                child: const Text('GO',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 32)),
                onPressed: answer,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Color(0xD7542B).withOpacity(1),
                  padding: EdgeInsets.all(12),
                )),
          ],
        )
      ],
    );
  }
}
