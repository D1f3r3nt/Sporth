import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporth/models/models.dart';

class DatabaseEvento {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String COLLECTION_NAME = "eventos";

  Future<void> saveEvento(EventoDto evento) async {
    await _db.collection(COLLECTION_NAME).doc().set(evento.toJson());
  }
}
