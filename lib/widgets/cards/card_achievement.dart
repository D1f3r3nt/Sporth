import 'package:flutter/material.dart';
import 'package:sporth/models/asset/logros_asset.dart';
import 'package:sporth/utils/utils.dart';

class CardAchievement extends StatelessWidget {
  final LogrosAsset logro;

  const CardAchievement({super.key, required this.logro});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => PopupUtils.dialogAchievement(context, logro),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: ColorsUtils.grey,
            image: DecorationImage(
                image: AssetImage('image/logros/${logro.image}'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
