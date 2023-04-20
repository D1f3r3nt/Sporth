import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool _containsUser(List<UserDto> participantes, UserDto user) {
    return participantes.where((element) => element.idUser == user.idUser).toList().isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final EventoDto eventoDto = ModalRoute.of(context)!.settings.arguments as EventoDto;
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final DatabaseEvento databaseEvento = DatabaseEvento();

    inscribirse() {
      if (userProvider.currentUser!.idUser == eventoDto.anfitrion.idUser) {
        Snackbar.errorSnackbar(context, 'Este es tu evento');
      } else {
        databaseEvento.inscribe(eventoDto.id, userProvider.currentUser!.idUser);
        Navigator.pop(context);
      }
    }

    message() {
      // TODO: Cambiar por privado
      Navigator.pushReplacementNamed(context, 'chats');
    }

    showPeople() {
      PopupUtils().dialogScrollUsers(context, eventoDto.participantes);
    }

    tapShare() {}

    atras() => Navigator.pop(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: EffectUtils.linearBlues,
        ),
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                width: size.width,
                height: size.height * 0.3,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: eventoDto.imagen.contains('http') ? NetworkImage(eventoDto.imagen) : AssetImage('image/banners/${eventoDto.imagen}') as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 5,
                child: PopButton(
                  text: 'Atras',
                  onPressed: atras,
                  colorWhite: true,
                ),
              ),
              Positioned(
                top: size.height * 0.2,
                height: size.height * 0.8,
                width: size.width,
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorsUtils.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(70.0)),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 35.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(eventoDto.anfitrion.urlImagen),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              eventoDto.anfitrion.username,
                              style: TextUtils.kanitBold_18,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          eventoDto.name,
                          style: TextUtils.kanitItalic_24_black,
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.access_time),
                                const SizedBox(width: 10),
                                Text(
                                  eventoDto.timeFormat,
                                  style: TextUtils.kanit_18_black,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined),
                                const SizedBox(width: 10),
                                Text(
                                  eventoDto.ubicacion,
                                  style: TextUtils.kanit_18_black,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  eventoDto.dia.day.toString(),
                                  style: TextUtils.kanitItalic_24_blue,
                                ),
                                Text(
                                  eventoDto.month,
                                  style: TextUtils.kanit_16_grey,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  (eventoDto.precio == 0) ? 'Free' : '${eventoDto.precio} €',
                                  style: TextUtils.kanitItalic_24_blue,
                                ),
                                const Text(
                                  'Precio',
                                  style: TextUtils.kanit_16_grey,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  eventoDto.maximo.toString(),
                                  style: TextUtils.kanitItalic_24_blue,
                                ),
                                const Text(
                                  'Maximo',
                                  style: TextUtils.kanit_16_grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ToastCard(
                              nombre: eventoDto.deporte.nombre,
                              active: true,
                            ),
                            GestureDetector(
                              onTap: showPeople,
                              child: Row(
                                children: [
                                  const Icon(Icons.people),
                                  const SizedBox(width: 5.0),
                                  Text(
                                    eventoDto.participantes.length.toString(),
                                    style: TextUtils.kanit_16_black,
                                  ),
                                  const SizedBox(width: 10.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Expanded(
                          child: ListView(
                            children: [
                              Text(
                                eventoDto.descripcion,
                                style: TextUtils.kanit_16_black,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 80.0,
                          child: Row(
                            children: [
                              Expanded(
                                child: ButtonInput(
                                  text: _containsUser(eventoDto.participantes, userProvider.currentUser!) ? 'Inscribirse' : 'Chat',
                                  funcion: _containsUser(eventoDto.participantes, userProvider.currentUser!) ? inscribirse : message,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              IconButton(
                                onPressed: tapShare,
                                icon: const Icon(Icons.share),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
