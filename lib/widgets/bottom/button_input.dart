import 'package:flutter/material.dart';

import 'package:sporth/utils/utils.dart';

class ButtonInput extends StatelessWidget {
  final String text;
  final Function()? funcion;
  final Color color;
  final TextStyle style;

  const ButtonInput({
    super.key,
    required this.text,
    required this.funcion,
    this.color = ColorsUtils.black,
    this.style = TextUtils.kanitItalic_24_white,
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
        child: Center(
          child: Text(
            text,
            style: style,
          ),
        ),
      ),
    );
  }
}
