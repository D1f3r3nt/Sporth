import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sporth/utils/utils.dart';

class Gateway extends StatelessWidget {
  const Gateway({super.key});

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
      body: CircularProgressIndicator(),
    );
  }

  void home(BuildContext context) async {
    // Tutorial
    /*if (Preferences.isFirstTime) {
      Navigator.pushReplacementNamed(context, 'tutorial');
      return;
    }*/
    Navigator.pushReplacementNamed(context, 'home');
  }
}
