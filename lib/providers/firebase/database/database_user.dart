import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sporth/models/models.dart';

class DatabaseUser {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String COLLECTION_NAME = "users";

  // =====================================================================================
  // =====================================================================================
  // =====================================================================================
  // =====================================================================================
  // API CALLS
  // =====================================================================================
  // =====================================================================================
  // =====================================================================================
  // =====================================================================================

  // =============
  // GET
  // =============
  Future<UserDto> getUser(String idUser) async {
    log('GET -- USER');
    DocumentReference documentReference = _db.collection(COLLECTION_NAME).doc(idUser);
    UserDto user = await documentReference.get().then((value) => UserDto.fromMap(value.data() as Map<String, dynamic>));

    return user;
  }

  Future<bool> existsUser(String idUser) async {
    log('GET -- EXISTS USER');
    DocumentReference documentReference = _db.collection(COLLECTION_NAME).doc(idUser);
    return await documentReference.get().then((value) => value.exists);
  }

  // =============
  // POST
  // =============
  Future<void> saveUser(UserDto user) async {
    log('POST -- SAVE USER');
    await _db.collection(COLLECTION_NAME).doc(user.idUser).set(user.toMap());
  }
}
