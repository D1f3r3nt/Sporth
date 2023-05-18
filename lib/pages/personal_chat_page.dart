import 'package:cloud_firestore/cloud_firestore.dart';
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
    final ChatRequest currentChat = ModalRoute.of(context)!.settings.arguments as ChatRequest;

    final UserDto currentUser = Provider.of<UserProvider>(context).currentUser!;
    
    final ChatProvider chatProvider = Provider.of<ChatProvider>(context);
    final EventosProvider eventosProvider = Provider.of<EventosProvider>(context);
    
    UserRequest? otherUser = currentChat.anfitriones
        .where((user) => user.idUser != currentUser.idUser)
        .toList()
        .first;

    atras() {
      eventosProvider.eventoChat = null;
      Navigator.pushReplacementNamed(context, CHATS);
    }

    enviar() {
      FocusScope.of(context).unfocus();
      
      chatProvider.sendMessage(currentChat.idChat!, messageController.text, currentUser);
      messageController.clear();
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
                          ? NetworkImage(otherUser.urlImagen)
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
                              ? otherUser.nombre
                              : eventosProvider.eventoChat!.name,
                          style: TextUtils.kanitItalic_24_black,
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: chatProvider.getMensajes(currentChat.idChat!),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator.adaptive();
                                } else {
                                  dynamic data = snapshot.data;
                                  List<dynamic> mensajes = data.docs.map((e) => MensajeApi.fromJson(e.data())).toList();
                                  
                                  
                                 return mensajes.isEmpty
                                      ? Center(
                                            child:
                                            Image.asset('image/no_tienes_mensajes.png'),
                                        )
                                      : ListView.builder(
                                        reverse: true,
                                        itemCount: mensajes.length,
                                        itemBuilder: (context, index) {
                                          MensajeApi mensaje = mensajes[index];
                                          String? user;
                                          /*
                                          if (eventosProvider.eventoChat != null &&
                                              mensaje.editor != currentUser.idUser) {
                                            user = mensaje.editor.username;
                                          }
                                          */
                                           
                                          return ChatMessage(
                                            ourMessage: mensaje.editor == currentUser.idUser,
                                            message: mensaje.mensaje,
                                            user: user,
                                          );
                                        },
                                      );
                                }
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
