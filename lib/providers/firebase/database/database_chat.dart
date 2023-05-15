import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporth/models/models.dart';

class DatabaseChat {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String COLLECTION_NAME = "chats";
  final String SUBCOLLECTION_NAME = "mensajes";

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
  Future<List<ChatApi>> getChats() async {
    log('GET -- CHATS');

    final CollectionReference chatsReference = _db.collection(COLLECTION_NAME);
    QuerySnapshot query = await chatsReference.get();

    return query.docs.map((chat) {
      ChatApi chatApi = ChatApi.fromJson(chat.data() as Map<String, dynamic>);
      chatApi = chatApi.copyWith(idChat: chat.id);
      return chatApi;
    }).toList();
  }

  Future<ChatApi?> getChatByEvent(String idEvent) async {
    log('GET -- CHAT EVENT');

    final CollectionReference chatsReference = _db.collection(COLLECTION_NAME);
    QuerySnapshot query =
        await chatsReference.where('idEvent', isEqualTo: idEvent).get();

    return query.docs.isEmpty
        ? null
        : query.docs
            .map((chat) {
              ChatApi chatApi =
                  ChatApi.fromJson(chat.data() as Map<String, dynamic>);
              chatApi = chatApi.copyWith(idChat: chat.id);
              return chatApi;
            })
            .toList()
            .first;
  }

  Future<String> anyChatUser(String idUser, String idOtherUser) async {
    log('GET -- ANY CHAT USER');

    CollectionReference chatsReference = _db.collection(COLLECTION_NAME);

    QuerySnapshot query = await chatsReference
        .where('anfitriones', arrayContainsAny: [idUser, idOtherUser])
        .where('idEvent', isNull: true)
        .get();

    return query.docs.isEmpty ? '' : query.docs.first.id;
  }

  // =============
  // POST
  // =============
  Future<String> saveChat(ChatApi chatApi) async {
    log('POST -- SAVE CHAT');

    DocumentReference documentReference = _db.collection(COLLECTION_NAME).doc();
    await documentReference.set(chatApi.toJson());

    return documentReference.id;
  }

  // =============
  // PUT
  // =============
  Future<void> updateMessage(
    String idChat,
    String mensaje,
    String idUser,
  ) async {
    log('PUT -- UPDATE MESSAGE');

    MensajeApi newMensaje = MensajeApi(
      editor: idUser,
      mensaje: mensaje,
      creacion: DateTime.now(),
    );

    DocumentReference documentReference =
        _db.collection("$COLLECTION_NAME/$idChat/$SUBCOLLECTION_NAME").doc();
    await documentReference.set(newMensaje.toJson());
  }

  Future<void> updateChat(ChatApi chatApi) async {
    log('PUT -- UPDATE CHAT');

    DocumentReference documentReference =
        _db.collection(COLLECTION_NAME).doc(chatApi.idChat);
    await documentReference.update(chatApi.toJson());
  }
}
