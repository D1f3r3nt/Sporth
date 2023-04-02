import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';

class SelectImageBottom extends StatelessWidget {
  final Function() onTapCamera;
  final Function() onTapGallery;
  SelectImageBottom({
    super.key,
    required this.onTapCamera,
    required this.onTapGallery,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SelectImage(
            icono: const Icon(Icons.image),
            nombre: 'Galeria',
            onTap: onTapGallery,
          ),
          SelectImage(
            icono: const Icon(Icons.camera),
            nombre: 'Camara',
            onTap: onTapCamera,
          ),
        ],
      ),
    );
  }
}

class SelectImage extends StatelessWidget {
  final Function() onTap;
  final String nombre;
  final Icon icono;

  const SelectImage({
    super.key,
    required this.onTap,
    required this.nombre,
    required this.icono,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: size.height * 0.1,
            width: size.height * 0.1,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0), gradient: EffectUtils.linearBlues),
            child: icono,
          ),
          Text(
            nombre,
            style: TextUtils.kanit_18_black,
          ),
        ],
      ),
    );
  }
}
