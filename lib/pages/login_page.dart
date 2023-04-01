import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

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
              const SizedBox(height: 20),
              const FormInput(
                icon: Icon(
                  Icons.email,
                  color: ColorsUtils.black,
                ),
                placeholder: 'Email',
                fillColor: ColorsUtils.lightblue,
              ),
              const SizedBox(height: 20),
              const FormInput(
                icon: Icon(
                  Icons.lock,
                  color: ColorsUtils.black,
                ),
                placeholder: 'Contraseña',
                fillColor: ColorsUtils.lightblue,
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text(
                    'Has olvidado la contraseña?',
                    style: TextUtils.kanit_16_white,
                  ),
                  onPressed: () {},
                ),
              ),
              const Expanded(child: SizedBox()),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ButtonGoogleInput(),
              ),
              const Expanded(child: SizedBox()),
              const Text(
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
