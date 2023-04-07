import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';

class Gateway extends StatelessWidget {
  Gateway({super.key});
  final databaseUser = DatabaseUser();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushReplacementNamed(context, 'login');
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

  void home(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.currentUser = await databaseUser.getUser(FirebaseAuth.instance.currentUser!.uid);

    // Tutorial
    /*if (Preferences.isFirstTime) {
      Navigator.pushReplacementNamed(context, 'tutorial');
      return;
    }*/

    Navigator.pushReplacementNamed(context, 'home');
  }
}
