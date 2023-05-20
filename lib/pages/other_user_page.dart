import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/repository/repository.dart';
import 'package:sporth/service/service.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class OtherUserPage extends StatefulWidget {
  const OtherUserPage({super.key});

  @override
  State<OtherUserPage> createState() => _OtherUserPageState();
}

class _OtherUserPageState extends State<OtherUserPage> {
  bool waiting = false;
  
  @override
  Widget build(BuildContext context) {
    final UserRequest otherUser = ModalRoute.of(context)!.settings.arguments as UserRequest;
    
    final Size size = MediaQuery.of(context).size;
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final UserRequest currentUser = userProvider.currentUser!;
    
    final ChatService chatProvider = ChatService();
    final DeportesProvider deportesProvider = Provider.of<DeportesProvider>(context);
    final EventosProvider eventosProvider = Provider.of<EventosProvider>(context);
    final LogrosProvider logrosProvider = Provider.of<LogrosProvider>(context);
    
    final UserRepository userService = UserRepository();

    final List<DeportesAsset> listDeportes = deportesProvider.deportes
        .where((element) => otherUser.gustos.contains(element.id))
        .toList();

    final List<LogrosAsset> listLogros = logrosProvider.logros
        .where((element) => otherUser.logros.contains(element.id))
        .toList();

    atras() => Navigator.pop(context);

    seguir() async {
      setState(() {
        waiting = true;
      });
      try {
        await userService.updateSeguidor(currentUser, otherUser.idUser);
        await userProvider.update();
      } catch (error) {
        // TODO toast
        print(error);
      }
      setState(() {
        waiting = false;
      });
    }

    chat() async {
      ChatRequest chat = ChatRequest(
        anfitriones: [currentUser, otherUser],
      );

      String chatId = await chatProvider.anyChatUser(currentUser.idUser, otherUser.idUser);

      if (chatId.isEmpty) await chatProvider.saveChat(chat);

      Navigator.pushReplacementNamed(context, CHAT_PERSONAL, arguments: chat);
    }

    dejar() async {
      setState(() {
        waiting = true;
      });
      try {
        await userService.updateDejar(currentUser, otherUser.idUser);
        await userProvider.update();
      } catch (error) {
        // TODO toast
        print(error);
      }
      setState(() {
        waiting = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsUtils.white,
        title: Text(
          otherUser.username,
          style: TextUtils.kanit_18_grey,
        ),
        centerTitle: true,
        leadingWidth: 100.0,
        leading: PopButton(
          text: 'Atras',
          onPressed: atras,
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: ColorsUtils.white,
          child: Column(
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        otherUser.seguidores.length.toString(),
                        style: TextUtils.kanitItalic_24_blue,
                      ),
                      const Text(
                        'Seguidores',
                        style: TextUtils.kanit_18_black,
                      )
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(otherUser.urlImagen),
                    radius: 50.0,
                  ),
                  Column(
                    children: [
                      Text(
                        otherUser.seguidos.length.toString(),
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
                otherUser.nombre,
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
              SizedBox(
                height: 80.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: (waiting) 
                            ? const Center(child: CircularProgressIndicator.adaptive())
                            : ButtonInput(
                          text: currentUser.seguidos.contains(otherUser.idUser)
                              ? 'Dejar'
                              : 'Seguir',
                          funcion:
                              currentUser.seguidos.contains(otherUser.idUser)
                                  ? dejar
                                  : seguir,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      IconButton(
                        onPressed: chat,
                        icon: const Icon(Icons.chat),
                      ),
                    ],
                  ),
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
                child: FutureBuilder<List<EventRequest>>(
                  future: eventosProvider.getEventsByUser(otherUser.idUser),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator.adaptive());
                    } else if (snapshot.hasError) {
                      return ErrorWidget(snapshot.error as Exception);
                    } else {
                      List<EventRequest> events = snapshot.data!;
                      return events.isEmpty
                          ? Image.asset(
                            'image/usuario_no_tiene_evento.png',
                            height: size.height * 0.4,
                          )
                          : ListView.builder(
                            itemCount: events.length,
                            padding:
                            const EdgeInsets.only(right: 15.0, left: 15.0, top: 10.0),
                            itemBuilder: (context, index) {
                              if (index > 0 && index % 2 == 0) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    BannerAdCard(width: size.width * 0.85),
                                    const SizedBox(height: 25),
                                    CardPublicacion(eventRequest: events[index]),
                                  ],
                                );
                              }
                              return CardPublicacion(eventRequest: events[index]);
                            },
                          );
                    }
                  },
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*

*/
