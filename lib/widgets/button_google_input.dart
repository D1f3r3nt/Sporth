import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sporth/models/dto/user_dto.dart';
import 'package:sporth/providers/firebase/auth/google_auth.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';

class ButtonGoogleInput extends StatelessWidget {
  const ButtonGoogleInput({super.key});

  @override
  Widget build(BuildContext context) {
    final singUpProvider = Provider.of<SingUpProvider>(context);
    final databaseUser = DatabaseUser();
    final googleAuth = GoogleAuth();

    _loginGoogle() async {
      await googleAuth.login();

      User user = FirebaseAuth.instance.currentUser!;

      if (await databaseUser.existsUser(user.uid)) {
        Navigator.pushReplacementNamed(context, '/');
        return;
      }

      singUpProvider.addDatos(user.email!, user.displayName ?? '', user.uid);
      singUpProvider.addPersonal(user.displayName ?? '', '', user.photoURL ?? '', DateTime.now(), user.phoneNumber ?? '');

      Navigator.pushReplacementNamed(context, 'gustos');
    }

    return GestureDetector(
      onTap: _loginGoogle,
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
