import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/chat_card.dart';
import 'package:sporth/widgets/widgets.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'home'),
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
                        child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return ChatCard(
                              onTap: () {},
                              nombre: 'Marc Santisteban',
                              username: 'msantisteban',
                              image:
                                  'https://m8p8m9h3.stackpathcdn.com/wp-content/uploads/2021/11/que-tipo-de-persona-te-gustaria-ser-730x411-SP.jpg',
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
