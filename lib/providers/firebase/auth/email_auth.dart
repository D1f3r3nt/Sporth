import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sporth/utils/utils.dart';

class EmailAuth {
  Future<String> singUp(BuildContext context, {required String email, required String password, required String name}) async {
    log('EMAIL_SING_UP');
    try {
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      credential.user!.updateDisplayName(name);
      log('CORRECT - EMAIL_SING_UP');
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Snackbar.errorSnackbar(context, 'La contrasenya es muy débil');
      } else if (e.code == 'email-already-in-use') {
        Snackbar.errorSnackbar(context, 'Este email ya existe');
      }
    } catch (e) {}

    log('ERROR - EMAIL_SING_UP');
    return '';
  }

  Future<String> logIn(BuildContext context, {required String email, required String password}) async {
    log('EMAIL_LOG_IN');
    try {
      var userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      log('CORRECT - EMAIL_LOG_IN');
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Snackbar.errorSnackbar(context, 'Usuario no encontrado');
      } else if (e.code == 'wrong-password') {
        Snackbar.errorSnackbar(context, 'Contraseña incorrecta');
      }
    }

    log('ERROR - EMAIL_LOG_IN');
    return '';
  }

  Future<void> logOut(BuildContext context) async {
    log('EMAIL_LOG_OUT');
    try {
      await FirebaseAuth.instance.signOut();
      log('CORRECT - EMAIL_LOG_OUT');
    } catch (e) {
      log('ERROR - EMAIL_LOG_OUT');
    }
  }

  Future<void> newPassword(BuildContext context, {required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    Snackbar.correctSnackbar(context, 'Se ha enviado un email con los pasos a seguir, revise su bandeja de entrada');
  }
}
