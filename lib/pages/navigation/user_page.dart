import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/cards/banner_ad_card.dart';
import 'package:sporth/widgets/widgets.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final DeportesProvider deportesProvider = Provider.of<DeportesProvider>(context);
    final EventosProvider eventosProvider = Provider.of<EventosProvider>(context);
    final LogrosProvider logrosProvider = Provider.of<LogrosProvider>(context);
    final UserDto user = userProvider.currentUser!;

    final List<DeportesAsset> listDeportes = deportesProvider.deportes
        .where((element) => user.gustos.contains(element.id))
        .toList();

    final List<LogrosAsset> listLogros = logrosProvider.logros
        .where((element) => user.logros.contains(element.id))
        .toList();

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
              user.nombre,
              style: TextUtils.kanitItalic_24_black,
            ),
            if (listLogros.isNotEmpty)
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listLogros.length,
                  itemBuilder: (context, index) {
                    return CardAchievement(logro: listLogros[index]);
                  },
                ),
              ),
            if (listDeportes.isNotEmpty)
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
              child: eventosProvider.eventsByUser.isEmpty
              ? Image.asset(
                'image/usuario_no_tiene_evento.png',
                height: size.height * 0.4,
              )
              : ListView.builder(
                itemCount: eventosProvider.eventsByUser.length,
                padding:
                const EdgeInsets.only(right: 15.0, left: 15.0, top: 10.0),
                itemBuilder: (context, index) {
                  if (index > 0 && index % 2 == 0) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BannerAdCard(width: size.width * 0.85),
                        const SizedBox(height: 25),
                        CardPublicacion(eventoDto: eventosProvider.eventsByUser[index]),
                      ],
                    );
                  }
                  return CardPublicacion(eventoDto: eventosProvider.eventsByUser[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
