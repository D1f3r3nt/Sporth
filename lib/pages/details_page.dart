import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/repository/chat_repository.dart';
import 'package:sporth/service/service.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool _containsUser(List<UserRequest> participantes, UserRequest user) {
    return participantes
        .where((element) => element.idUser == user.idUser)
        .toList()
        .isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final EventRequest eventRequest = ModalRoute.of(context)!.settings.arguments as EventRequest;
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final EventosProvider eventosProvider = Provider.of<EventosProvider>(context);
    final DeportesProvider deportesProvider = Provider.of<DeportesProvider>(context);
    final ShareService shareProvider = ShareService();
    final UserRequest currentUser = Provider.of<UserProvider>(context).currentUser!;
    final ChatService chatProvider = ChatService();
    final AnalyticsUtils analyticsUtils = AnalyticsUtils();

    inscribirse() async {
      if (userProvider.currentUser!.idUser == eventRequest.anfitrion.idUser) {
        Snackbar.errorSnackbar(context, 'Este es tu evento');
      } else {
        if (eventRequest.maximo <= eventRequest.participantes.length + 1) {
          Snackbar.errorSnackbar(context, 'El evento esta lleno');
          return;
        }
        
        if (eventRequest.privado != null) {
          bool? result = await PopupUtils.dialogTextInput(context, eventRequest.privado!);
          
          if (result == null || !result) {
            Snackbar.errorSnackbar(context, 'Contraseña incorrecta');
            return;
          }
        } 
        
        await eventosProvider.inscribe(eventRequest.id!, userProvider.currentUser!.idUser);
        DeportesAsset deporte = await deportesProvider.getDeporteById(eventRequest.deporte);
        analyticsUtils.registerEvent('Inscribe_to_event', {
          "deporte": deporte.nombre
        });
        Navigator.pop(context);
      }
    }

    salir() async {
        await eventosProvider.uninscribe(eventRequest.id!, userProvider.currentUser!.idUser);
        DeportesAsset deporte = await deportesProvider.getDeporteById(eventRequest.deporte);
        analyticsUtils.registerEvent('Uninscribe_to_event', {
          "deporte": deporte.nombre
        });
        Navigator.pop(context);
    }

    message() async {
      ChatRequest? chat = await chatProvider.getChatByEvent(eventRequest.id!);

      if (chat == null) {
        chat = ChatRequest(
          anfitriones: [currentUser, eventRequest.anfitrion],
          idEvent: eventRequest.id!,
        );

        await chatProvider.saveChat(chat);
        
      } else {
        if (!chat.anfitriones.contains(currentUser.idUser)) {
          chat.anfitriones.add(currentUser);
          await chatProvider.updateChat(chat);
        }
      }

      eventosProvider.eventoChat = eventRequest;
      Navigator.pushReplacementNamed(context, CHAT_PERSONAL, arguments: chat);
    }

    showPeople() {
      PopupUtils.dialogScrollUsers(context, eventRequest.participantes);
    }

    tapShare() async {
      shareProvider.shareEvent(eventRequest.imagen, eventRequest.name);
      DeportesAsset deporte = await deportesProvider.getDeporteById(eventRequest.deporte);
      analyticsUtils.registerEvent('Share_event', {
        "deporte": deporte.nombre
      });
    }

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
                      image: eventRequest.imagen.contains('http')
                          ? NetworkImage(eventRequest.imagen)
                          : AssetImage('image/banners/${eventRequest.imagen}')
                              as ImageProvider,
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
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(70.0)),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15.0, left: 35.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserTile(userRequest: eventRequest.anfitrion),
                        const SizedBox(height: 5.0),
                        Text(
                          eventRequest.name,
                          style: TextUtils.kanitItalic_24_black,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
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
                                  eventRequest.timeFormat,
                                  style: TextUtils.kanit_18_black,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined),
                                SizedBox(
                                  width: size.width * 0.45,
                                  child: Text(
                                    eventRequest.ubicacion,
                                    style: TextUtils.kanit_18_black,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
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
                                  eventRequest.dia.day.toString(),
                                  style: TextUtils.kanitItalic_24_blue,
                                ),
                                Text(
                                  eventRequest.month,
                                  style: TextUtils.kanit_16_grey,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  (eventRequest.precio == 0)
                                      ? 'Free'
                                      : '${eventRequest.precio} €',
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
                                  eventRequest.maximo.toString(),
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
                              nombre: deportesProvider.deportes.where((element) => element.id == eventRequest.deporte).first.nombre, 
                              active: true,
                            ),
                            GestureDetector(
                              onTap: showPeople,
                              child: Row(
                                children: [
                                  const Icon(Icons.people),
                                  const SizedBox(width: 5.0),
                                  Text(
                                    eventRequest.participantes.length.toString(),
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
                                eventRequest.descripcion,
                                style: TextUtils.kanit_16_black,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 80.0,
                          child: Row(
                            children: [
                              if (!_containsUser(eventRequest.participantes, userProvider.currentUser!))
                                IconButton(
                                  onPressed: message,
                                  icon: const Icon(Icons.chat),
                                ),
                              if (!_containsUser(eventRequest.participantes, userProvider.currentUser!))
                                const SizedBox(width: 10.0),
                              Expanded(
                                child: ButtonInput(
                                  text: _containsUser(eventRequest.participantes,
                                          userProvider.currentUser!)
                                      ? 'Inscribirse'
                                      : 'Salir',
                                  funcion: _containsUser(
                                      eventRequest.participantes,
                                          userProvider.currentUser!)
                                      ? inscribirse
                                      : salir,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              IconButton(
                                onPressed: tapShare,
                                icon: Icon(Icons.adaptive.share),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 60.0),
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
