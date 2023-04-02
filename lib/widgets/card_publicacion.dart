import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class CardPublicacion extends StatelessWidget {
  const CardPublicacion({super.key});

  final imagePersona = 'https://m8p8m9h3.stackpathcdn.com/wp-content/uploads/2021/11/que-tipo-de-persona-te-gustaria-ser-730x411-SP.jpg';
  final namePersona = 'msantisteban';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imagePersona),
            ),
            const SizedBox(width: 10),
            Text(
              namePersona,
              style: TextUtils.kanitBold_18,
            ),
          ],
        ),
        const SizedBox(height: 15),
        const CardEvent(),
        const SizedBox(height: 25),
      ],
    );
  }
}
