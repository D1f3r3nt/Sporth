import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  _filterDeportes(int id, List<int> gustos) {
    return gustos.contains(id);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final DeportesProvider deportesProvider = Provider.of<DeportesProvider>(context);
    final UserDto user = userProvider.currentUser!;
    final List<DeportesLocal> listDeportes = deportesProvider.deportes.where((element) => _filterDeportes(element.id, user.gustos)).toList();

    return SafeArea(
      child: SizedBox(
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
                      user.seguidores.length.toString(),
                      style: TextUtils.kanitItalic_24_blue,
                    ),
                    const Text(
                      'Seguidores',
                      style: TextUtils.kanit_18_black,
                    )
                  ],
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(user.urlImagen),
                  radius: 50.0,
                ),
                Column(
                  children: [
                    Text(
                      user.seguidos.length.toString(),
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
              '${user.nombre} ${user.apellidos}',
              style: TextUtils.kanitItalic_24_black,
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: user.logros.length,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: CardAchievement(),
                  );
                },
              ),
            ),
            SizedBox(
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
