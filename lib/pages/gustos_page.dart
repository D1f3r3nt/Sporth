import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/firebase/database/database_user.dart';
import 'package:sporth/providers/providers.dart';
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
    final Size size = MediaQuery.of(context).size;
    final deportesProvider = Provider.of<DeportesProvider>(context);
    final singUpProvider = Provider.of<SingUpProvider>(context);
    final databaseUser = DatabaseUser();

    List<DeportesDto> gustos = deportesProvider.deportesGustos;

    _finalizar() {
      singUpProvider.addGustos(gustos.where((element) => element.selected).toList());

      databaseUser.saveUser(singUpProvider.newUser);

      Navigator.pushReplacementNamed(context, '/');
    }

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
                                onTap: () => setState(() {
                                  element.selected = !element.selected;
                                }),
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
                  funcion: _finalizar,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
