import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.userDto,
  });

  final UserDto userDto;

  @override
  Widget build(BuildContext context) {
    final UserProvider currentUser = Provider.of<UserProvider>(context);
    final EventosProvider eventosProvider = Provider.of<EventosProvider>(context);

    goUser() {
      if (userDto.idUser == currentUser.currentUser!.idUser) return;
      
      // Para traer los eventos del usuario
      eventosProvider.getEventosByUser(userDto.idUser);
      
      Navigator.pushNamed(context, OTHER_USER, arguments: userDto);
    }

    return GestureDetector(
      onTap: goUser,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(userDto.urlImagen),
          ),
          const SizedBox(width: 10),
          Text(
            userDto.username,
            style: TextUtils.kanitBold_18,
          ),
        ],
      ),
    );
  }
}
