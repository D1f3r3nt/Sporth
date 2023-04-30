import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporth/models/models.dart';

class DatabaseUser {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String COLLECTION_NAME = "users";

  // =============
  // PUT
  // =============
  Future<void> getFriendLogro(UserDto user) async {
    if (!user.logros.contains(4)) {
      await updateLogro(user, 4);
    }
  }

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
    DocumentReference documentReference =
        _db.collection(COLLECTION_NAME).doc(idUser);
    UserDto user = await documentReference
        .get()
        .then((value) => UserDto.fromMap(value.data() as Map<String, dynamic>));

    return user;
  }

  Future<bool> existsUser(String idUser) async {
    log('GET -- EXISTS USER');
    DocumentReference documentReference =
        _db.collection(COLLECTION_NAME).doc(idUser);
    return await documentReference.get().then((value) => value.exists);
  }

  // =============
  // POST
  // =============
  Future<void> saveUser(UserDto user) async {
    log('POST -- SAVE USER');
    await _db.collection(COLLECTION_NAME).doc(user.idUser).set(user.toMap());
  }

  // =============
  // PUT
  // =============
  Future<void> updateUser(UserDto user) async {
    log('PUT -- UPDATE USER');

    // Usuario principal
    await _db.collection(COLLECTION_NAME).doc(user.idUser).update(user.toMap());
  }

  Future<void> updateSeguidor(UserDto user, String idUser) async {
    log('PUT -- UPDATE SEGUIR');

    // Usuario principal
    user.seguidos.add(idUser);
    await _db.collection(COLLECTION_NAME).doc(user.idUser).update(user.toMap());

    // Otro usuario
    UserDto otherUser = await getUser(idUser);
    otherUser.seguidores.add(user.idUser);
    await _db
        .collection(COLLECTION_NAME)
        .doc(otherUser.idUser)
        .update(otherUser.toMap());

    await getFriendLogro(user);
  }

  Future<void> updateDejar(UserDto user, String idUser) async {
    log('PUT -- UPDATE DEJAR');

    // Usuario principal
    user.seguidos.remove(idUser);
    await _db.collection(COLLECTION_NAME).doc(user.idUser).update(user.toMap());

    // Otro usuario
    UserDto otherUser = await getUser(idUser);
    otherUser.seguidores.remove(user.idUser);
    await _db
        .collection(COLLECTION_NAME)
        .doc(otherUser.idUser)
        .update(otherUser.toMap());
  }

  Future<void> updateLogro(UserDto user, int idLogro) async {
    log('PUT -- UPDATE LOGRO');

    user.logros.add(idLogro);

    await _db.collection(COLLECTION_NAME).doc(user.idUser).update(user.toMap());
  }
}
