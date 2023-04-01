import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class PersonalPage extends StatelessWidget {
  const PersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: ColorsUtils.white,
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
              GestureDetector(
                onTap: () {},
                child: const CircleAvatar(
                  backgroundColor: ColorsUtils.blue,
                  radius: 60.0,
                  child: Icon(
                    Icons.add,
                    color: ColorsUtils.black,
                    size: 30.0,
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  'Perfil y datos personales',
                  style: TextUtils.kanit_16_black,
                ),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: FormInput(
                  icon: const Icon(
                    Icons.person,
                    color: ColorsUtils.black,
                  ),
                  controller: TextEditingController(),
                  placeholder: 'Nombre',
                  fillColor: ColorsUtils.white,
                  validator: (p0) => null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: FormInput(
                  icon: const Icon(
                    Icons.person,
                    color: ColorsUtils.black,
                  ),
                  placeholder: 'Apellido',
                  controller: TextEditingController(),
                  fillColor: ColorsUtils.white,
                  validator: (p0) => null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: FormInput(
                  icon: const Icon(
                    Icons.phone,
                    color: ColorsUtils.black,
                  ),
                  placeholder: 'Telefono',
                  controller: TextEditingController(),
                  fillColor: ColorsUtils.white,
                  validator: (p0) => null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: FormInput(
                  icon: const Icon(
                    Icons.calendar_month,
                    color: ColorsUtils.black,
                  ),
                  controller: TextEditingController(),
                  placeholder: 'Fecha de nacimiento',
                  fillColor: ColorsUtils.white,
                  validator: (p0) => null,
                ),
              ),
              const Expanded(child: SizedBox()),
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
      ),
    );
  }
}
