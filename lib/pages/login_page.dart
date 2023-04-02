import 'package:flutter/material.dart';
import 'package:sporth/providers/firebase/auth/email_auth.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailRegex = RegExp(r"^[^@]+@[^@]+\.[a-zA-Z]{2,}$");
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailAuth = EmailAuth();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    _login() async {
      if (_formKey.currentState!.validate()) {
        await _emailAuth.logIn(
          context,
          email: _emailController.text,
          password: _passwordController.text,
        );

        Navigator.pushReplacementNamed(context, '/');
      }
    }

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
                    child: const Text(
                      'Has olvidado la contraseña?',
                      style: TextUtils.kanit_16_white,
                    ),
                    onPressed: () => Navigator.pushReplacementNamed(context, 'new-password'),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ButtonInput(
                    text: 'ENTRAR',
                    funcion: _login,
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
                    funcion: () => Navigator.pushReplacementNamed(context, 'sing-up'),
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
