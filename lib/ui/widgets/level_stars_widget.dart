import 'package:flutter/material.dart';

class LevelStarsWidget extends StatelessWidget {
  LevelStarsWidget({Key? key, required this.level}) : super(key: key);
  int level;

  @override
  Widget build(BuildContext context) {
    print('level $level');
    return Row(
      children: List.generate(
          level, (index) => Icon(Icons.star, color: Colors.yellow)),
    );
  }
}
