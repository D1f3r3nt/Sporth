import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';

class GustosButtons extends StatelessWidget {
  final bool active;
  final String image;
  final String text;
  final Function() onTap;

  const GustosButtons({
    super.key,
    required this.active,
    required this.image,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            boxShadow: EffectUtils.dropShadow,
            color: active ? ColorsUtils.blue : ColorsUtils.creme,
            borderRadius: BorderRadius.circular(active ? 50.0 : 40.0)),
        width: active ? 100 : 80,
        height: active ? 100 : 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'image/icons/$image',
              fit: BoxFit.fitWidth,
              width: active ? 60 : 40,
            ),
            Text(
              text,
              style:
                  active ? TextUtils.kanit_14_black : TextUtils.kanit_12_black,
            )
          ],
        ),
      ),
    );
  }
}
