import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sporth/utils/utils.dart';

class EmailAuth {
  Future<String> singUp(BuildContext context, {required String email, required String password, required String name}) async {
    log('POST -- EMAIL SING UP');

    try {
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      credential.user!.updateDisplayName(name);
      return credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Snackbar.errorSnackbar(context, 'La contrasenya es muy débil');
      } else if (e.code == 'email-already-in-use') {
        Snackbar.errorSnackbar(context, 'Este email ya existe');
      }
    }

    return '';
  }

  Future<String> logIn(BuildContext context, {required String email, required String password}) async {
    log('GET -- EMAIL LOG IN');
    try {
      var userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Snackbar.errorSnackbar(context, 'Usuario no encontrado');
      } else if (e.code == 'wrong-password') {
        Snackbar.errorSnackbar(context, 'Contraseña incorrecta');
      }
    }

    return '';
  }

  Future<void> logOut(BuildContext context) async {
    log('POST - EMAIL LOG OUT');
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {}
  }

  Future<void> newPassword(BuildContext context, {required String email}) async {
    log('POST - EMAIL NEW PASSWORD');
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    Snackbar.correctSnackbar(context, 'Se ha enviado un email con los pasos a seguir, revise su bandeja de entrada');
  }
}
