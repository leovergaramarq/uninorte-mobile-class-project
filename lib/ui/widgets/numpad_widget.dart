import 'package:flutter/material.dart';

class NumpadWidget extends StatelessWidget {
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
                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
                child: const Text('0',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 32)),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(12),
                )),
            SizedBox(width: 36),
            ElevatedButton(
                onPressed: () {},
                child: const Text('C',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 32)),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.all(12),
                )),
            SizedBox(width: 36),
            ElevatedButton(
                onPressed: () {},
                child: const Text('GO',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 32)),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.all(12),
                )),
          ],
        )
      ],
    );
  }
}
