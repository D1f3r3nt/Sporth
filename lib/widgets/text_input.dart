import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';

class TextInput extends StatelessWidget {
  final String placeholder;

  const TextInput({super.key, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextUtils.kanitItalic_24_black,
      decoration: const InputDecoration(
        hintText: 'Nombre',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorsUtils.black,
            width: 2.0,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorsUtils.black,
            width: 2.0,
          ),
        ),
        hintStyle: TextUtils.kanitItalic_24_grey,
      ),
    );
  }
}
