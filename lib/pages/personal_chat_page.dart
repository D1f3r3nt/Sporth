import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class PersonalChatPage extends StatelessWidget {
  PersonalChatPage({super.key});

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ChatDto currentChat =
        ModalRoute.of(context)!.settings.arguments as ChatDto;
    final ChatProvider chatProvider = Provider.of<ChatProvider>(context);
    final EventosProvider eventosProvider =
        Provider.of<EventosProvider>(context);
    final UserDto currentUser = Provider.of<UserProvider>(context).currentUser!;

    chatProvider.getChat(currentChat.idChat!);

    List<MensajeDto> mensajes = chatProvider.mensajes;
    UserDto? otherUser;

    if (currentChat.idEvent != null) {
      eventosProvider.getEvento(currentChat.idEvent!);
    } else {
      otherUser = currentChat.anfitriones
          .where((user) => user.idUser != currentUser.idUser)
          .toList()
          .first;
    }

    atras() => Navigator.pushReplacementNamed(context, 'chats');

    enviar() async {
      chatProvider.sendMessage(
          currentChat.idChat!, messageController.text, currentUser.idUser);
      messageController.text = '';
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: EffectUtils.linearBlues,
        ),
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PopButton(
                    text: 'Atras',
                    onPressed: atras,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, top: 5.0),
                    child: CircleAvatar(
                      backgroundImage: eventosProvider.eventoChat == null
                          ? NetworkImage(otherUser!.urlImagen)
                          : eventosProvider.eventoChat!.imagen.contains('http')
                              ? NetworkImage(eventosProvider.eventoChat!.imagen)
                              : AssetImage(
                                      'image/banners/${eventosProvider.eventoChat!.imagen}')
                                  as ImageProvider,
                      radius: 20.0,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15.0),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorsUtils.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(70.0)),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        alignment: Alignment.center,
                        child: Text(
                          eventosProvider.eventoChat == null
                              ? otherUser!.nombre
                              : eventosProvider.eventoChat!.name,
                          style: TextUtils.kanitItalic_24_black,
                        ),
                      ),
                      Expanded(
                        child: mensajes.isEmpty
                            ? Center(
                                child:
                                    Image.asset('image/no_tienes_mensajes.png'))
                            : ListView.builder(
                                reverse: true,
                                itemCount: mensajes.length,
                                itemBuilder: (context, index) {
                                  MensajeDto mensaje = mensajes[index];

                                  return ChatMessage(
                                    ourMessage: mensaje.editor.idUser ==
                                        currentUser.idUser,
                                    message: mensaje.mensaje,
                                  );
                                },
                              ),
                      ),
                      SizedBox(
                        height: 80.0,
                        child: Row(
                          children: [
                            Expanded(
                              child: FormInput(
                                icon: null,
                                placeholder: 'Escribe',
                                controller: messageController,
                                fillColor: ColorsUtils.white,
                                styleText: TextUtils.kanit_18_grey,
                                validator: (p0) => null,
                              ),
                            ),
                            IconButton(
                              onPressed: enviar,
                              icon: const Icon(Icons.send),
                            ),
                          ],
                        ),
                      )
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
