import 'package:flutter/material.dart';

import 'package:sporth/utils/utils.dart';

class ButtonIconInput extends StatelessWidget {
  final String text;
  final Function()? funcion;
  final Color color;
  final TextStyle style;
  final Icon icono;

  const ButtonIconInput({
    super.key,
    required this.text,
    required this.funcion,
    this.color = ColorsUtils.black,
    this.style = TextUtils.kanitItalic_24_white,
    required this.icono,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funcion,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          boxShadow: EffectUtils.dropShadow,
          borderRadius: BorderRadius.circular(25.0),
        ),
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icono,
            const SizedBox(width: 10.0),
            Text(
              text,
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}
