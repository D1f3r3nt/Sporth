import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sporth/utils/utils.dart';

class FormInput extends StatelessWidget {
  final Form? form;
  final Icon? icon;
  final String placeholder;
  final Color fillColor;
  final TextStyle styleText;
  final String? Function(String?) validator;
  final TextInputType textInputType;
  final bool password;
  final TextEditingController controller;
  final Function()? onTap;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const FormInput({
    super.key,
    required this.icon,
    required this.placeholder,
    required this.fillColor,
    required this.validator,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.password = false,
    this.form,
    this.onTap,
    this.onChanged,
    this.styleText = TextUtils.kanit_18_black, 
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: EffectUtils.dropShadow,
          borderRadius: BorderRadius.circular(60.0),
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: textInputType,
          inputFormatters: inputFormatters,
          obscureText: password,
          validator: validator,
          onTap: onTap,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: icon == null ? const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0) : const EdgeInsets.symmetric(vertical: 5.0),
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
