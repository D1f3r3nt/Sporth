import 'package:flutter/material.dart';
import 'package:sporth/utils/color_utils.dart';
import 'package:sporth/utils/text_utils.dart';

class FormInput extends StatelessWidget {
  final Form? form;
  final Icon icon;
  final String placeholder;

  const FormInput({
    super.key,
    this.form,
    required this.icon,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: PhysicalModel(
        elevation: 5.0,
        color: ColorsUtils.black,
        borderRadius: BorderRadius.circular(50.0),
        child: TextFormField(
          validator: (value) => (value == null || value.isEmpty)
              ? 'Introduzca: $placeholder'
              : null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60.0),
              borderSide: BorderSide.none,
            ),
            prefixIcon: icon,
            prefixIconColor: ColorsUtils.black,
            hintText: placeholder,
            hintStyle: TextUtils.kanit_18_black,
            fillColor: ColorsUtils.lightblue,
            filled: true,
          ),
        ),
      ),
    );
  }
}
