import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class PersonalChatPage extends StatelessWidget {
  const PersonalChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserDto user = ModalRoute.of(context)!.settings.arguments as UserDto;
    final TextEditingController messageController = TextEditingController();

    atras() => Navigator.pushReplacementNamed(context, 'chats');

    enviar() {}

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
                      backgroundImage: NetworkImage(user.imagen),
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
                          user.nombre,
                          style: TextUtils.kanitItalic_24_black,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            if (index % 2 == 0) {
                              return const ChatMessage(
                                ourMessage: true,
                                message: 'Hola que des fsefvse few tal?',
                              );
                            }
                            return const ChatMessage(
                              ourMessage: false,
                              message: 'Hola que ddscdes fsefvse few ffwe few fwe few ftal?',
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
