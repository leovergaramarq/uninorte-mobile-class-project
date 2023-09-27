import 'package:flutter/material.dart';

class LevelStars extends StatelessWidget {
  LevelStars({Key? key, required this.level}) : super(key: key);
  int level;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          level, (index) => Icon(Icons.star, color: Colors.yellow)),
    );
  }
}
