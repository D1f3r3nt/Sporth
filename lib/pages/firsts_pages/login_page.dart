import 'package:flutter/material.dart';

import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegExp _emailRegex = RegExp(r"^[^@]+@[^@]+\.[a-zA-Z]{2,}$");
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final EmailAuth _emailAuth = EmailAuth();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    login() async {
      if (_formKey.currentState!.validate()) {
        await _emailAuth.logIn(
          context,
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        Navigator.pushReplacementNamed(context, INITIAL);
      }
    }

    tapRecuperarContrasenia() => Navigator.pushReplacementNamed(context, NEW_PASSWORD);

    tapRegistrarse() => Navigator.pushReplacementNamed(context, SING_UP);

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'image/logo_transparente.png',
                  width: size.width * 0.4,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                FormInput(
                  icon: const Icon(
                    Icons.email,
                    color: ColorsUtils.black,
                  ),
                  textInputType: TextInputType.emailAddress,
                  placeholder: 'Email',
                  controller: _emailController,
                  fillColor: ColorsUtils.lightblue,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Pon un valor';
                    if (!_emailRegex.hasMatch(value)) return 'Pon un email';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                FormInput(
                  icon: const Icon(
                    Icons.lock,
                    color: ColorsUtils.black,
                  ),
                  password: true,
                  placeholder: 'Contraseña',
                  controller: _passwordController,
                  fillColor: ColorsUtils.lightblue,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Pon un valor';
                    if (value.length < 6) return 'La contraseña ha ser mas grande que 6';
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: tapRecuperarContrasenia,
                    child: const Text(
                      'Has olvidado la contraseña?',
                      style: TextUtils.kanit_16_white,
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ButtonInput(
                    text: 'ENTRAR',
                    funcion: login,
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
                    funcion: tapRegistrarse,
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
      ),
    );
  }
}
