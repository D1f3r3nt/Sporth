import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  final _googleSingIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<void> login() async {
    log('GOOGLE_LOG_IN');
    final googleUser = await _googleSingIn.signIn(); // Muestra la pantalla de login con Google

    if (googleUser == null) {
      log('ERROR - GOOGLE_LOG_IN');
      return;
    }
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    log('CORRECT - GOOGLE_LOG_IN');
  }

  Future<void> logout() async {
    log('GOOGLE_LOG_OUT');
    try {
      await _googleSingIn.disconnect();
      await FirebaseAuth.instance.signOut();
      log('CORRECT - GOOGLE_LOG_OUT');
    } catch (e) {
      log('ERROR - GOOGLE_LOG_OUT');
    }
  }
}
