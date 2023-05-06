import 'package:flutter/material.dart';

import 'package:sporth/utils/utils.dart';

class EffectUtils {
  static final List<BoxShadow> dropShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.25),
      blurRadius: 4.0,
      offset: const Offset(4, 4),
    ),
    BoxShadow(
      color: Colors.white.withOpacity(0.25),
      blurRadius: 4.0,
      offset: const Offset(-4, -4),
    ),
  ];

  static const LinearGradient linearBlues = LinearGradient(
    colors: [
      ColorsUtils.blue,
      ColorsUtils.lightblue,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient linearGreys = LinearGradient(
    colors: [
      ColorsUtils.creme,
      ColorsUtils.grey,
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}
