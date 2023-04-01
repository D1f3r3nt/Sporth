import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';

class CardEvent extends StatelessWidget {
  const CardEvent({super.key});

  final image = 'badminton.png';
  final ubicacion = 'Palma de Mallorca, España';
  final dia = '15 jul';
  final precio = 0;
  final nombre = 'Partido de futbol';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('image/banners/$image'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              strokeAlign: BorderSide.strokeAlignCenter,
              width: 2.0,
              color: ColorsUtils.grey,
            ),
          ),
          height: 200,
        ),
        Container(
          height: 65,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorsUtils.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topLeft: Radius.circular(30.0),
            ),
            border: Border.all(
              strokeAlign: BorderSide.strokeAlignCenter,
              width: 1.0,
              color: ColorsUtils.grey,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      nombre,
                      style: TextUtils.kanit_18_black,
                    ),
                    Text(
                      '$ubicacion | $dia',
                      style: TextUtils.kanit_16_grey,
                    ),
                  ],
                ),
                Text(
                  (precio == 0) ? 'Free' : '$precio €',
                  style: TextUtils.kanitItalic_24_black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
