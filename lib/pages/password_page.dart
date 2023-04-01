import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class PasswordPage extends StatelessWidget {
  const PasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            children: [
              PopButton(
                text: 'Atras',
                onPressed: () {},
              ),
              const SizedBox(height: 15.0),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorsUtils.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(70.0)),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10.0, left: 50.0),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Recuperar contraseña',
                          style: TextUtils.kanitItalic_24_black,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Ponga su email, se le enviara un email con las instrucciones para recuperar la contraseña',
                          style: TextUtils.kanit_16_black,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: FormInput(
                          icon: Icon(
                            Icons.email,
                            color: ColorsUtils.black,
                          ),
                          placeholder: 'Email',
                          fillColor: ColorsUtils.white,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ButtonInput(
                          text: 'ENVIAR',
                          funcion: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
