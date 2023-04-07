import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class CardPublicacion extends StatelessWidget {
  const CardPublicacion({super.key, required this.eventoDto});

  final EventoDto eventoDto;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'other-user', arguments: eventoDto.anfitrion),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(eventoDto.anfitrion.urlImagen),
              ),
              const SizedBox(width: 10),
              Text(
                eventoDto.anfitrion.username,
                style: TextUtils.kanitBold_18,
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        CardEvent(eventoDto: eventoDto),
        const SizedBox(height: 25),
      ],
    );
  }
}
