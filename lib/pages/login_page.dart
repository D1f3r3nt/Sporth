import 'package:flutter/material.dart';
import 'package:sporth/utils/color_utils.dart';
import 'package:sporth/utils/effect_utils.dart';
import 'package:sporth/utils/text_utils.dart';
import 'package:sporth/widgets/button_google_input.dart';
import 'package:sporth/widgets/button_input.dart';
import 'package:sporth/widgets/form_input.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: EffectUtils.linearBlues,
        ),
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'image/logo_transparente.png',
                width: size.width * 0.4,
                fit: BoxFit.contain,
              ),
              const FormInput(
                icon: Icon(
                  Icons.email,
                  color: ColorsUtils.black,
                ),
                placeholder: 'Email',
              ),
              const SizedBox(height: 20),
              const FormInput(
                icon: Icon(
                  Icons.lock,
                  color: ColorsUtils.black,
                ),
                placeholder: 'Contraseña',
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text(
                      'Has olvidado la contraseña?',
                      style: TextUtils.kanit_16_white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ButtonInput(
                  text: 'ENTRAR',
                  funcion: () {},
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                color: ColorsUtils.black,
                thickness: 1.0,
                indent: 30.0,
                endIndent: 30.0,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ButtonInput(
                  text: 'REGISTRARSE',
                  funcion: () {},
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ButtonGoogleInput(),
              ),
              const Expanded(child: SizedBox()),
              Text(
                'Desarrollado por Diferent Company.',
                style: TextUtils.kanit_16_white,
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
