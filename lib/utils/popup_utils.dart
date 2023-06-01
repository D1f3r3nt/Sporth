import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

class PopupUtils {
  static dialogScrollUsers(BuildContext context, List<UserRequest> users) {
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
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: UserTile(userRequest: users[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }

  static dialogAchievement(BuildContext context, LogrosAsset logro) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('image/logros/${logro.image}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                logro.name,
                style: TextUtils.kanit_18_black,
              ),
            ],
          ),
          content: Text(
            logro.description,
            style: TextUtils.kanit_16_grey,
          ),
        );
      },
    );
  }
  
  static Future<bool?> dialogTextInput(BuildContext context, String correctText) {
    TextEditingController controller = TextEditingController();
    
    return showDialog<bool>(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Este evento es privado',
            style: TextUtils.kanit_18_black,
          ),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Contraseña'),
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, controller.text.trim() == correctText);
              }, 
              child: const Text('Inscribirse'),
            )
          ],
        );
      },
    );
  }
}
