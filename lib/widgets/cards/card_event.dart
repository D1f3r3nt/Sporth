import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/utils/utils.dart';

class CardEvent extends StatelessWidget {
  const CardEvent({super.key, required this.eventoDto});

  final EventoDto eventoDto;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
    goEvento() => Navigator.pushNamed(context, DETAILS, arguments: eventoDto);

    return GestureDetector(
      onTap: goEvento,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: eventoDto.imagen.contains('http') ? NetworkImage(eventoDto.imagen) : AssetImage('image/banners/${eventoDto.imagen}') as ImageProvider,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                strokeAlign: BorderSide.strokeAlignCenter,
                width: 2.0,
                color: ColorsUtils.grey,
              ),
            ),
            height: 200,
          ),
          Container(
            height: 65,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorsUtils.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topLeft: Radius.circular(30.0),
              ),
              border: Border.all(
                strokeAlign: BorderSide.strokeAlignCenter,
                width: 1.0,
                color: ColorsUtils.grey,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.6,
                        child: Text(
                          eventoDto.name,
                          style: TextUtils.kanit_18_black,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.6,
                        child: Text(
                          '${eventoDto.ubicacion} | ${eventoDto.diaFormatShow}',
                          style: TextUtils.kanit_16_grey,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    (eventoDto.precio == 0) ? 'Free' : '${eventoDto.precio} €',
                    style: TextUtils.kanitItalic_24_black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
