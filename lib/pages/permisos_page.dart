import 'package:flutter/material.dart';

import 'package:sporth/service/service.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class PermisosPage extends StatefulWidget {
  const PermisosPage({super.key});

  @override
  State<PermisosPage> createState() => _PermisosPageState();
}

class _PermisosPageState extends State<PermisosPage> {
  final PositionService _positionProvider = PositionService();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    notNow() {
        Navigator.pushReplacementNamed(context, INITIAL);
    }

    agree() async {
        await _positionProvider.checkAll(context);
      
        Navigator.pushReplacementNamed(context, INITIAL);
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
                            'Permisos de ubicacion',
                            style: TextUtils.kanitItalic_24_black,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        SizedBox(
                          height: size.height * 0.45,
                          child: ListView(
                            padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                            children:const [Text(
                              style: TextUtils.kanit_16_black,
                              'Esta aplicación utiliza la ubicación en segundo plano para proporcionarte una experiencia personalizada y ofrecerte las siguientes funciones:\n\n - Filtrar eventos en función de su ubicación actual.\n\n - Proporcionar una mejor experiencia de usuario.\n\nLos datos de localización se recopilan incluso cuando la aplicación está cerrada o no se utiliza. Estos datos también se utilizan para proporcionar anuncios/soporte publicitario/soporte de anuncios.\n\nAl utilizar nuestra aplicación, usted acepta el uso de su ubicación en segundo plano para los fines descritos anteriormente.',
                            ),
                          ]),
                        ),
                        const Expanded(child: SizedBox()),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ButtonInput(
                            text: 'Ahora no',
                            color: ColorsUtils.creme,
                            style: TextUtils.kanitItalic_24_black,
                            funcion: notNow,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ButtonInput(
                            text: 'De acuerdo',
                            funcion: agree,
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
