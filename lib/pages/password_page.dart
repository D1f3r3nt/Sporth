import 'package:flutter/material.dart';
import 'package:sporth/providers/firebase/auth/email_auth.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailRegex = RegExp(r"^[^@]+@[^@]+\.[a-zA-Z]{2,}$");
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailProvider = EmailAuth();

    _enviar() {
      if (_formKey.currentState!.validate()) {
        emailProvider.newPassword(context, email: _emailController.text);

        Navigator.pushReplacementNamed(context, 'login');
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
              children: [
                PopButton(
                  text: 'Atras',
                  onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: FormInput(
                            icon: const Icon(
                              Icons.email,
                              color: ColorsUtils.black,
                            ),
                            textInputType: TextInputType.emailAddress,
                            placeholder: 'Email',
                            controller: _emailController,
                            fillColor: ColorsUtils.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Pon un valor';
                              if (!_emailRegex.hasMatch(value)) return 'Pon un email';

                              return null;
                            },
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ButtonInput(
                            text: 'ENVIAR',
                            funcion: _enviar,
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
