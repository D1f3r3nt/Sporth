import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/widgets/cards/banner_ad_card.dart';
import 'package:sporth/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  late List<EventoDto> eventos;

  HomePage({super.key}) {
    eventos = [];
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final EventosProvider eventosProvider =
        Provider.of<EventosProvider>(context);

    // Wait for build
    Future.delayed(Duration.zero, () => eventosProvider.getAllEventos());
    eventos = eventosProvider.allEvents;

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: (eventos.isEmpty)
            ? Image.asset(
                'image/usuario_no_tiene_evento.png',
                height: size.height * 0.4,
              )
            : RefreshIndicator(
                onRefresh: () => eventosProvider.refresh(),
                child: ListView.builder(
                  padding:
                      const EdgeInsets.only(right: 15.0, left: 15.0, top: 10.0),
                  itemCount: eventos.length,
                  itemBuilder: (context, index) {
                    if (index > 0 && index % 2 == 0) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BannerAdCard(width: size.width * 0.85),
                          const SizedBox(height: 25),
                          CardPublicacion(eventoDto: eventos[index]),
                        ],
                      );
                    }
                    return CardPublicacion(eventoDto: eventos[index]);
                  },
                ),
              ),
      ),
    );
  }
}
