import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sporth/providers/providers.dart';

import 'package:sporth/utils/utils.dart';

class Gateway extends StatelessWidget {
  Gateway({super.key});
  final databaseUser = DatabaseUser();

  void home(BuildContext context) async {
    final UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    final EventosProvider eventosProvider = Provider.of<EventosProvider>(context, listen: false);

    userProvider.currentUser = await databaseUser.getUser(FirebaseAuth.instance.currentUser!.uid);

    // Tutorial
    /*if (Preferences.isFirstTime) {
      Navigator.pushReplacementNamed(context, 'tutorial');
      return;
    }*/

    // Para traer los eventos del usuario
    eventosProvider.getEventosByUser(userProvider.currentUser!.idUser);
    
    Navigator.pushReplacementNamed(context, HOME);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushReplacementNamed(context, LOGIN);
      } else {
        home(context);
      }
    });

    return const Scaffold(
      backgroundColor: ColorsUtils.blue,
      body: Center(
          child: CircularProgressIndicator(
        color: ColorsUtils.white,
      )),
    );
  }
}
