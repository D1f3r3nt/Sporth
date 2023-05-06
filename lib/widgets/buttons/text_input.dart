import 'package:flutter/material.dart';

import 'package:sporth/utils/utils.dart';

class TextInput extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const TextInput({
    super.key,
    required this.placeholder,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextUtils.kanitItalic_24_black,
      controller: controller,
      validator: validator,
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
