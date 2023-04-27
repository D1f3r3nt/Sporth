import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/providers/firebase/database/database_chat.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class PersonalChatPage extends StatelessWidget {
  PersonalChatPage({super.key});

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String idChat = ModalRoute.of(context)!.settings.arguments as String;
    final DatabaseChat databaseChat = Provider.of<DatabaseChat>(context);
    final UserDto currentUser = Provider.of<UserProvider>(context).currentUser!;

    databaseChat.getChat(idChat);
    final ChatDto? chat = databaseChat.chat;

    final UserDto? otherUser = chat?.getOtherAnfitrion(currentUser.idUser);
    List<MensajeDto>? mensajes = chat?.mensajes.reversed.toList();

    atras() => Navigator.pushReplacementNamed(context, 'chats');

    enviar() async {
      await databaseChat.updateMessage(chat!, messageController.text, currentUser.idUser);
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
          child: chat == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
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
                            backgroundImage: NetworkImage(chat.fotoEvento == null ? otherUser!.urlImagen : chat.fotoEvento!),
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
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(70.0)),
                        ),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 10.0),
                              alignment: Alignment.center,
                              child: Text(
                                chat.nombreEvento == null ? otherUser!.nombre : chat.nombreEvento!,
                                style: TextUtils.kanitItalic_24_black,
                              ),
                            ),
                            Expanded(
                              child: mensajes!.isEmpty
                                  ? Center(child: Image.asset('image/no_tienes_mensajes.png'))
                                  : ListView.builder(
                                      reverse: true,
                                      itemCount: mensajes.length,
                                      itemBuilder: (context, index) {
                                        MensajeDto mensaje = mensajes[index];

                                        return ChatMessage(
                                          ourMessage: mensaje.editor.idUser == currentUser.idUser,
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
