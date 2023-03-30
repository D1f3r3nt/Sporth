import 'package:flutter/material.dart';
import 'package:sporth/utils/effect_utils.dart';
import 'package:sporth/utils/utils.dart';

class ToastCard extends StatelessWidget {
  final String nombre;
  final bool active;

  const ToastCard({
    super.key,
    required this.nombre,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: active ? EffectUtils.linearBlues : null,
        color: active ? null : ColorsUtils.grey,
        borderRadius: BorderRadius.circular(14.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      height: 28.0,
      child: Text(
        nombre,
        style: TextUtils.kanit_16_black,
      ),
    );
  }
}
