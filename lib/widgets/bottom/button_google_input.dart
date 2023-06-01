import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:sporth/providers/providers.dart';
import 'package:sporth/repository/repository.dart';
import 'package:sporth/service/service.dart';
import 'package:sporth/utils/utils.dart';

class ButtonGoogleInput extends StatelessWidget {
  const ButtonGoogleInput({super.key});

  @override
  Widget build(BuildContext context) {
    final singUpProvider = Provider.of<SingUpProvider>(context);
    final UserRepository userService = UserRepository();
    final GoogleAuth googleAuth = GoogleAuth();

    loginGoogle() async {
      try {
        await googleAuth.login();
      } catch (e) {
        Toast.error('Algo ha ido mal');
      }

      User user = FirebaseAuth.instance.currentUser!;

      if (await userService.existsUser(user.uid)) {
        Navigator.pushReplacementNamed(context, INITIAL);
        return;
      }

      singUpProvider.addDatos(user.email!, user.displayName ?? '', user.uid);
      singUpProvider.addPersonal(user.displayName ?? '', '', user.photoURL ?? '', DateTime.now(), user.phoneNumber ?? '');

      Navigator.pushReplacementNamed(context, USERNAME_PAGE);
    }

    return GestureDetector(
      onTap: loginGoogle,
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
