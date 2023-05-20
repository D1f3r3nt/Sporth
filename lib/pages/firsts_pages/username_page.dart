import 'package:flutter/material.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/repository/repository.dart';

import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({super.key});

  @override
  State<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final SingUpProvider singUpProvider = Provider.of<SingUpProvider>(context);
    final UserRepository userRepository = UserRepository();

    seguir() async {
      if (_formKey.currentState!.validate()) {
        bool exists = await userRepository.existsUsername(_userController.text.trim());
        if (!exists) {
          singUpProvider.addUsername(_userController.text.trim());
          
          Navigator.pushReplacementNamed(context, GUSTOS);
        } else {
          Snackbar.errorSnackbar(context, 'Este username ya existe');
        }
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
                            'Usuario',
                            style: TextUtils.kanitItalic_24_black,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Ponga un usuario valido',
                            style: TextUtils.kanit_16_black,
                          ),
                        ),
                        const SizedBox(height: 20.0),
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
                              if (value == null || value.trim().isEmpty) return 'Pon un valor';
                              if (value.length < 4 || value.length > 15) {
                                return 'El usuario ha de tener entre 4 y 15 letras';
                              }
                              return null;
                            },
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ButtonInput(
                            text: 'SEGUIR',
                            funcion: seguir,
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
