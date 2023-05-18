import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/widgets/widgets.dart';

class CardPublicacion extends StatelessWidget {
  const CardPublicacion({super.key, required this.eventRequest});

  final EventRequest eventRequest;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserTile(userRequest: eventRequest.anfitrion),
        const SizedBox(height: 15),
        CardEvent(eventRequest: eventRequest),
        const SizedBox(height: 25),
      ],
    );
  }
}
