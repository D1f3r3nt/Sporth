import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/widgets/cards/banner_ad_card.dart';
import 'package:sporth/widgets/widgets.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final EventosProvider eventosProvider = Provider.of<EventosProvider>(context);
    
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder<List<EventRequest>>(
          future: eventosProvider.getAllEvents(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasError) {
              return ErrorWidget(snapshot.error as TypeError);
            } else {
              List<EventRequest> events = snapshot.data!;
              return (events.isEmpty)
                  ? Image.asset(
                      'image/usuario_no_tiene_evento.png',
                      height: size.height * 0.4,
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        setState(() {});
                      },
                      child: ListView.builder(
                        padding:
                        const EdgeInsets.only(right: 15.0, left: 15.0, top: 10.0),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          if (index > 0 && index % 2 == 0) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                BannerAdCard(width: size.width * 0.85),
                                const SizedBox(height: 25),
                                CardPublicacion(eventRequest: events[index]),
                              ],
                            );
                          }
                          return CardPublicacion(eventRequest: events[index]);
                        },
                      ),
                    );
            }
          },
        ),
      ),
    );
  }
}

/*

*/
