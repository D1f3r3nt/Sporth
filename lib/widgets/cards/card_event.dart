import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/utils/utils.dart';

class CardEvent extends StatelessWidget {
  const CardEvent({super.key, required this.eventRequest});

  final EventRequest eventRequest;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AnalyticsUtils analyticsUtils = AnalyticsUtils();
    
    goEvento() {
      /*analyticsUtils.registerEvent('Event_selected', {
        // TODO get en deportes
        "deporte": eventRequest.deporte.nombre,
      });*/
      Navigator.pushNamed(context, DETAILS, arguments: eventRequest);
    }

      return GestureDetector(
        onTap: goEvento,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: eventRequest.imagen.contains('http') ? NetworkImage(eventRequest.imagen) : AssetImage('image/banners/${eventRequest.imagen}') as ImageProvider,
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
                            eventRequest.name,
                            style: TextUtils.kanit_18_black,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.6,
                          child: Text(
                            '${eventRequest.ubicacion} | ${eventRequest.diaFormatShow}',
                            style: TextUtils.kanit_16_grey,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      (eventRequest.precio == 0) ? 'Free' : '${eventRequest.precio} €',
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
