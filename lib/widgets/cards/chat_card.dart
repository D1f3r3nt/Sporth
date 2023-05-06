import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';

class ChatCard extends StatelessWidget {
  final String nombre;
  final String username;
  final String image;
  final Function() onTap;

  const ChatCard({
    super.key,
    required this.nombre,
    required this.username,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        nombre,
        style: TextUtils.kanit_18_black,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        username,
        style: TextUtils.kanit_16_grey,
      ),
      leading: CircleAvatar(
        backgroundImage: image.contains('http')
            ? NetworkImage(image)
            : AssetImage('image/banners/$image') as ImageProvider,
        radius: 30.0,
      ),
      onTap: onTap,
    );
  }
}
