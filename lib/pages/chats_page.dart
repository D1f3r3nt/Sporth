import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    final ChatProvider chatProvider = Provider.of<ChatProvider>(context);
    final UserDto currentUser = Provider.of<UserProvider>(context).currentUser!;
    final EventosProvider eventosProvider = Provider.of<EventosProvider>(context);

    atras() {
      Navigator.pushReplacementNamed(context, HOME);
    }

    tapChat(ChatRequest chatRequest) => Navigator.pushReplacementNamed(
      context,
      CHAT_PERSONAL,
      arguments: chatRequest,
    );

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
                PopButton(
                  text: 'Atras',
                  onPressed: atras,
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
                          child: const Text(
                            'Chats',
                            style: TextUtils.kanitItalic_24_black,
                          ),
                        ),
                        Expanded(
                          child: FutureBuilder<List<ChatRequest>>(
                            future: chatProvider.getChats(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const Center(child: CircularProgressIndicator.adaptive());
                              } else if (snapshot.hasError) {
                                return ErrorWidget(snapshot.error as Exception);
                              } else {
                                List<ChatRequest> chats = snapshot.data!;
                                
                                return chats.isEmpty
                                    ? Center(
                                        child: Image.asset('image/no_tienes_chats.png'),
                                      )
                                    : RefreshIndicator(
                                        onRefresh: () async {
                                          setState(() {});
                                        },
                                        child: ListView.builder(
                                          itemCount: chats.length,
                                          itemBuilder: (context, index) {
                                            ChatRequest chat = chats[index];
      
                                            if (chat.idEvent == null) {
                                              UserRequest otherUser = chat.getOtherAnfitrion(currentUser.idUser);
      
                                              return ChatCard(
                                                onTap: () => tapChat(chat),
                                                nombre: otherUser.nombre,
                                                username: otherUser.username,
                                                image: otherUser.urlImagen,
                                              );
                                            } else {
                                              return FutureBuilder<EventRequest>(
                                                future: eventosProvider.getEvent(chat.idEvent!),
                                                builder: (context, snapshot) {
                                                  if (snapshot.connectionState != ConnectionState.waiting) {
                                                    EventRequest event = snapshot.data!;
                                                    return ChatCard(
                                                      onTap: () async {
                                                        eventosProvider.eventoChat = event;
                                                        tapChat(chat);
                                                      },
                                                      nombre: event.name,
                                                      username: '${event.diaFormat} - ${event.timeFormat}',
                                                      image: event.imagen,
                                                    );
                                                  }
                                                  return ChatCard(
                                                    onTap: () async {},
                                                    nombre: 'Cargando...',
                                                    username: 'Cargando...',
                                                    image: 'https://firebasestorage.googleapis.com/v0/b/sporth-c3c47.appspot.com/o/eventos.png?alt=media&token=9d33229e-ce18-4dc9-81db-d12e9971f65a',
                                                  );
                                                },
                                              );
                                            }
                                          },
                                        ),
                                    );
                              }
                            },
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

