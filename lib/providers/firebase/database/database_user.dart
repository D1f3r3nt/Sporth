import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporth/models/dto/user_dto.dart';

class DatabaseUser {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String COLLECTION_NAME = "users";

  Future<void> saveUser(UserDto user) async {
    await _db.collection(COLLECTION_NAME).doc(user.idUser).set(user.toMap());
  }

  Future<UserDto> getUser(String idUser) async {
    DocumentReference documentReference = _db.collection(COLLECTION_NAME).doc(idUser);
    UserDto user = await documentReference.get().then((value) => UserDto.fromMap(value.data() as Map<String, dynamic>));

    return user;
  }
}
