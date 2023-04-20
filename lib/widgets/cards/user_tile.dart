import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/utils/utils.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.userDto,
  });

  final UserDto userDto;

  @override
  Widget build(BuildContext context) {
    goUser() => Navigator.pushNamed(context, 'other-user', arguments: userDto);

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
