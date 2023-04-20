import 'package:flutter/material.dart';

import 'package:sporth/utils/utils.dart';

class CardAchievement extends StatelessWidget {
  const CardAchievement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: ColorsUtils.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
