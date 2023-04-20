import 'package:flutter/material.dart';

import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegExp _emailRegex = RegExp(r"^[^@]+@[^@]+\.[a-zA-Z]{2,}$");
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController = TextEditingController();
  final TextEditingController _userController = TextEditingController();

  bool _checkbox = false;

  @override
  Widget build(BuildContext context) {
    final emailAuth = EmailAuth();
    final singUpProvider = Provider.of<SingUpProvider>(context);

    singUp() async {
      if (_formKey.currentState!.validate()) {
        if (!_checkbox) {
          Snackbar.errorSnackbar(context, 'Tienes que aceptar las condiciones');
        } else {
          String uid = await emailAuth.singUp(
            context,
            email: _emailController.text,
            password: _passwordController.text,
            name: _userController.text,
          );

          if (uid.isNotEmpty) {
            singUpProvider.addDatos(_emailController.text, _userController.text, uid);
            Navigator.pushReplacementNamed(context, 'personal');
          }
        }
      }
    }

    entrar() => Navigator.pushReplacementNamed(context, 'login');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: EffectUtils.linearBlues,
        ),
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                PopButton(
                  text: 'Entrar',
                  onPressed: entrar,
                ),
                const SizedBox(height: 15.0),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ColorsUtils.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(70.0)),
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: FormInput(
                            icon: const Icon(
                              Icons.email,
                              color: ColorsUtils.black,
                            ),
                            placeholder: 'Email',
                            textInputType: TextInputType.emailAddress,
                            controller: _emailController,
                            fillColor: ColorsUtils.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Pon un valor';
                              }
                              if (!_emailRegex.hasMatch(value)) {
                                return 'Pon un email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: FormInput(
                            icon: const Icon(
                              Icons.person,
                              color: ColorsUtils.black,
                            ),
                            placeholder: 'Usuario',
                            controller: _userController,
                            fillColor: ColorsUtils.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Pon un valor';
                              }
                              if (value.length < 4 || value.length > 15) {
                                return 'El usuario ha de tener entre 4 y 15 letras';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: FormInput(
                            icon: const Icon(
                              Icons.lock,
                              color: ColorsUtils.black,
                            ),
                            password: true,
                            placeholder: 'Contraseña',
                            controller: _passwordController,
                            fillColor: ColorsUtils.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Pon un valor';
                              }
                              if (value.length < 6) {
                                return 'La contraseña ha ser mas grande que 6';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: FormInput(
                            icon: const Icon(
                              Icons.lock,
                              color: ColorsUtils.black,
                            ),
                            password: true,
                            placeholder: 'Confirmar contraseña',
                            controller: _passwordCheckController,
                            fillColor: ColorsUtils.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Pon un valor';
                              }
                              if (value != _passwordController.text) {
                                return 'Las contraseñas no coinciden';
                              }
                              return null;
                            },
                          ),
                        ),
                        CheckboxListTile(
                          value: _checkbox,
                          onChanged: (value) => setState(() {
                            _checkbox = value!;
                          }),
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
                            funcion: singUp,
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
      ),
    );
  }
}
