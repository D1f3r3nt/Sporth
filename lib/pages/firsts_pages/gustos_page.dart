import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/repository/repository.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class GustosPage extends StatefulWidget {
  const GustosPage({super.key});

  @override
  State<GustosPage> createState() => _GustosPageState();
}

class _GustosPageState extends State<GustosPage> {
  @override
  Widget build(BuildContext context) {
    final DeportesProvider deportesProvider = Provider.of<DeportesProvider>(context);
    final SingUpProvider singUpProvider = Provider.of<SingUpProvider>(context);
    final UserRepository userService = UserRepository();

    List<DeportesDto> gustos = deportesProvider.deportesGustos;

    finalizar() {
      singUpProvider.addGustos(gustos.where((element) => element.selected).toList());

      userService.saveUser(singUpProvider.newUser);

      Navigator.pushReplacementNamed(context, INITIAL);
    }

    tapGustosButtons(DeportesDto element) => setState(() {
          element.selected = !element.selected;
        });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: ColorsUtils.white,
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  '¿Cuales són tus gustos?',
                  style: TextUtils.kanitItalic_24_black,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: const Text(
                  'Perfil y datos personales',
                  style: TextUtils.kanit_16_black,
                ),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 30,
                      runSpacing: 20,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: gustos
                          .map((element) => GustosButtons(
                                active: element.selected,
                                image: element.imagen,
                                text: element.nombre,
                                onTap: () => tapGustosButtons(element),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ButtonInput(
                  text: 'FINALIZAR',
                  funcion: finalizar,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
