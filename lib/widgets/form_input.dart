import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';

class FormInput extends StatelessWidget {
  final Form? form;
  final Icon? icon;
  final String placeholder;
  final Color fillColor;
  final TextStyle styleText;

  const FormInput({
    super.key,
    this.form,
    required this.icon,
    required this.placeholder,
    required this.fillColor,
    this.styleText = TextUtils.kanit_18_black,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: EffectUtils.dropShadow,
          borderRadius: BorderRadius.circular(60.0),
        ),
        child: TextFormField(
          validator: (value) => (value == null || value.isEmpty)
              ? 'Introduzca: $placeholder'
              : null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: icon == null
                ? const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)
                : const EdgeInsets.symmetric(vertical: 5.0),
            prefixIcon: icon,
            prefixIconColor: ColorsUtils.black,
            hintText: placeholder,
            hintStyle: styleText,
            fillColor: fillColor,
            filled: true,
          ),
        ),
      ),
    );
  }
}
