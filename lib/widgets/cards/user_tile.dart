import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.userRequest,
  });

  final UserRequest userRequest;

  @override
  Widget build(BuildContext context) {
    final UserProvider currentUser = Provider.of<UserProvider>(context);

    goUser() {
      if (userRequest.idUser == currentUser.currentUser!.idUser) return;
      
      Navigator.pushNamed(context, OTHER_USER, arguments: userRequest);
    }

    return GestureDetector(
      onTap: goUser,
      child: Row(
        children: [
          CircleAvatar(
            child: ClipOval(
              child: FadeInImage.assetNetwork(
                placeholder: 'image/user.png',
                image: userRequest.urlImagen,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            userRequest.username,
            style: TextUtils.kanitBold_18,
          ),
        ],
      ),
    );
  }
}
