import 'package:flutter/material.dart';

class LevelStarsWidget extends StatelessWidget {
  LevelStarsWidget({Key? key, required this.level, this.starSize = 28})
      : super(key: key);

  int level;
  int starSize;

  @override
  Widget build(BuildContext context) {
    print('level $level');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          level,
          (index) => Icon(
                Icons.star,
                color: Color(0xD3B549).withOpacity(1),
                size: starSize.toDouble(),
              )),
    );
  }
}
