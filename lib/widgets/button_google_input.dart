import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sporth/utils/utils.dart';

class ButtonGoogleInput extends StatelessWidget {
  const ButtonGoogleInput({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: ColorsUtils.red_google,
          boxShadow: EffectUtils.dropShadow,
          borderRadius: BorderRadius.circular(25.0),
        ),
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              FontAwesomeIcons.google,
              color: ColorsUtils.white,
            ),
            SizedBox(width: 15.0),
            Text(
              "Entrar con Google",
              style: TextUtils.kanit_18_whtie,
            ),
          ],
        ),
      ),
    );
  }
}
