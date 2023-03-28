import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';

class ButtonInput extends StatelessWidget {
  final String text;
  final Function()? funcion;

  ButtonInput({
    required this.text,
    required this.funcion,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: funcion,
      child: Container(
        decoration: BoxDecoration(
          color: ColorsUtils.black,
          boxShadow: EffectUtils.dropShadow,
          borderRadius: BorderRadius.circular(25.0),
        ),
        height: 50.0,
        child: Center(
          child: Text(
            text,
            style: TextUtils.kanitItalic_24_white,
          ),
        ),
      ),
    );
  }
}
