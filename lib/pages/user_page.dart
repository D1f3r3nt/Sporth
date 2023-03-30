import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporth/providers/local/deportes_provider.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/card_achievement.dart';
import 'package:sporth/widgets/card_publicacion.dart';
import 'package:sporth/widgets/toast_card.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  final seguidores = 0;
  final seguidos = 3;
  final nombre = 'Usuario test';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final deportesProvider = Provider.of<DeportesProvider>(context);
    final listDeportes = deportesProvider.deportes;

    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      seguidores.toString(),
                      style: TextUtils.kanitItalic_24_blue,
                    ),
                    const Text(
                      'Seguidores',
                      style: TextUtils.kanit_18_black,
                    )
                  ],
                ),
                const CircleAvatar(
                  radius: 50.0,
                ),
                Column(
                  children: [
                    Text(
                      seguidos.toString(),
                      style: TextUtils.kanitItalic_24_blue,
                    ),
                    const Text(
                      'Seguidos',
                      style: TextUtils.kanit_18_black,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Text(
              nombre,
              style: TextUtils.kanitItalic_24_black,
            ),
            Container(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CardAchievement(),
                  );
                },
              ),
            ),
            Container(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listDeportes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ToastCard(
                      active: true,
                      nombre: listDeportes[index].nombre,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 0 + 1,
                itemBuilder: (context, index) {
                  return Image.asset(
                    'image/usuario_no_tiene_evento.png',
                    height: size.height * 0.4,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
