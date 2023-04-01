import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class SingUpPage extends StatelessWidget {
  const SingUpPage({super.key});

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
                text: 'Entrar',
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
                          'Bienvenido',
                          style: TextUtils.kanitItalic_24_black,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 50.0),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Registrate para poder ver los eventos',
                          style: TextUtils.kanit_16_black,
                        ),
                      ),
                      const Expanded(flex: 1, child: SizedBox()),
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
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: FormInput(
                          icon: Icon(
                            Icons.person,
                            color: ColorsUtils.black,
                          ),
                          placeholder: 'Usuario',
                          fillColor: ColorsUtils.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: FormInput(
                          icon: Icon(
                            Icons.lock,
                            color: ColorsUtils.black,
                          ),
                          placeholder: 'Contraseña',
                          fillColor: ColorsUtils.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: FormInput(
                          icon: Icon(
                            Icons.lock,
                            color: ColorsUtils.black,
                          ),
                          placeholder: 'Confirmar contraseña',
                          fillColor: ColorsUtils.white,
                        ),
                      ),
                      CheckboxListTile(
                        value: false,
                        onChanged: (value) {},
                        title: const Text(
                          'Aceptar las condiciones de privacidad',
                          style: TextUtils.kanit_16_black,
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      const Expanded(flex: 3, child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ButtonInput(
                          text: 'CONTINUAR',
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
