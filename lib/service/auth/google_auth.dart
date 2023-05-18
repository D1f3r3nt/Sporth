import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  final _googleSingIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<void> login() async {
    log('GET -- GOOGLE LOG IN');
    final googleUser = await _googleSingIn.signIn(); // Muestra la pantalla de login con Google

    if (googleUser == null) {
      return;
    }
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> logout() async {
    log('POST -- GOOGLE LOG OUT');
    try {
      await _googleSingIn.disconnect();
      await FirebaseAuth.instance.signOut();
    } catch (e) {}
  }
}
