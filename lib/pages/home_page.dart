import 'package:flutter/material.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final eventosProvider = Provider.of<EventosProvider>(context);
    eventosProvider.getAllEventosOneTime();

    final eventos = eventosProvider.allEventos;

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
                  padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 10.0),
                  itemCount: eventos.length,
                  itemBuilder: (context, index) {
                    return CardPublicacion(eventoDto: eventos[index]);
                  },
                ),
              ),
      ),
    );
  }
}
