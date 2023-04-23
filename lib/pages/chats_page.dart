import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class ChatsPage extends StatelessWidget {
  final user = UserDto(
    email: 'sanitstebanmarc@gmail.com',
    gustos: [],
    idUser: '',
    imagen: 'https://m8p8m9h3.stackpathcdn.com/wp-content/uploads/2021/11/que-tipo-de-persona-te-gustaria-ser-730x411-SP.jpg',
    logros: [],
    nacimiento: DateTime.now(),
    nombre: 'Marc Santisteban',
    seguidores: [],
    seguidos: [],
    telefono: '',
    username: 'msantisteban',
  );

  ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    atras() => Navigator.pushReplacementNamed(context, 'home');

    tapChat() => Navigator.pushReplacementNamed(
          context,
          'chat-personal',
          arguments: user,
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
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(70.0)),
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
                        child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return ChatCard(
                              onTap: tapChat,
                              nombre: user.nombre,
                              username: user.username,
                              image: user.imagen,
                            );
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
