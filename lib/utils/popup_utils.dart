import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/widgets/widgets.dart';

class PopupUtils {
  dialogScrollUsers(BuildContext context, List<UserDto> users) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Participantes'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                return UserTile(userDto: users[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
