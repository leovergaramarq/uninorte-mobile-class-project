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
            (index) => Padding(
                  padding: const EdgeInsets.all(
                      4.0), // Ajusta el espacio entre las imágenes
                  child: Image.asset(
                    'assets/img/star_level.png', // Ruta de tu imagen personalizada
                    width:
                        starSize.toDouble(), // Establece el ancho de la imagen
                    height:
                        starSize.toDouble(), // Establece la altura de la imagen
                  ),
                )));
  }
}
