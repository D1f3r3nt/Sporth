import 'package:flutter/material.dart';

import 'package:sporth/utils/utils.dart';

class SearchDeporte extends StatelessWidget {
  final bool active;
  final String image;
  final Function() onTap;

  const SearchDeporte({
    super.key,
    required this.active,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: EffectUtils.dropShadow,
                color: active ? ColorsUtils.blue : ColorsUtils.creme,
                borderRadius: BorderRadius.circular(35.0),
              ),
              width: 70,
              height: 70,
              child: Image.asset(
                'image/icons/$image',
                fit: BoxFit.fitWidth,
                width: 45.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
