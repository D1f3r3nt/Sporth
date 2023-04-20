import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/widgets/widgets.dart';

class CardPublicacion extends StatelessWidget {
  const CardPublicacion({super.key, required this.eventoDto});

  final EventoDto eventoDto;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserTile(userDto: eventoDto.anfitrion),
        const SizedBox(height: 15),
        CardEvent(eventoDto: eventoDto),
        const SizedBox(height: 25),
      ],
    );
  }
}
