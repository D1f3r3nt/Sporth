import 'package:flutter/material.dart';
import 'package:sporth/widgets/card_event.dart';
import 'package:sporth/widgets/card_publicacion.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 10.0),
          itemCount: 20,
          itemBuilder: (context, index) {
            return CardPublicacion();
          },
        ),
      ),
    );
  }
}
