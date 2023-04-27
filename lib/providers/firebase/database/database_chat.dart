import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';

class DatabaseChat extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String COLLECTION_NAME = "chats";
  final DatabaseUser databaseUser = DatabaseUser();

  List<ChatApi> chatsApi = [];
  List<ChatDto> chatsDto = [];
  ChatDto? chat;

  void _convertApiToDto() async {
    chatsDto = [];

    for (var chat in chatsApi) {
      chatsDto.add(ChatDto(
        anfitriones: await _convertRefToDto(chat.anfitriones),
        datosEvento: chat.datosEvento,
        fotoEvento: chat.fotoEvento,
        idChat: chat.idChat,
        nombreEvento: chat.nombreEvento,
        mensajes: await _convertMensajeApiToDto(chat.mensajes),
      ));
    }

    notifyListeners();
  }

  void _convertSimpleApiToDto(ChatApi chatApi) async {
    chat = ChatDto(
      anfitriones: await _convertRefToDto(chatApi.anfitriones),
      datosEvento: chatApi.datosEvento,
      fotoEvento: chatApi.fotoEvento,
      idChat: chatApi.idChat,
      nombreEvento: chatApi.nombreEvento,
      mensajes: await _convertMensajeApiToDto(chatApi.mensajes),
    );

    notifyListeners();
  }

  Future<List<UserDto>> _convertRefToDto(List<String> ref) async {
    List<UserDto> result = [];

    for (var reference in ref) {
      result.add(await databaseUser.getUser(reference));
    }

    return result;
  }

  Future<List<MensajeDto>> _convertMensajeApiToDto(List<MensajeApi> mensajes) async {
    List<MensajeDto> result = [];

    for (var msj in mensajes) {
      result.add(MensajeDto(
        editor: await databaseUser.getUser(msj.editor),
        mensaje: msj.mensaje,
        creacion: msj.creacion,
      ));
    }

    return result;
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
  void getChats() async {
    log('GET -- CHATS');

    CollectionReference chatsReference = _db.collection(COLLECTION_NAME);

    chatsReference.snapshots().listen((query) {
      chatsApi = [];

      chatsApi = query.docs.map((chat) {
        ChatApi userDto = ChatApi.fromJson(chat.data() as Map<String, dynamic>);
        userDto = userDto.copyWith(idChat: chat.id);
        return userDto;
      }).toList();

      _convertApiToDto();
    });
  }

  void getChat(String idChat) async {
    log('GET -- CHATS');

    DocumentReference documentReference = _db.collection(COLLECTION_NAME).doc(idChat);

    ChatApi chatApi = await documentReference.get().then((value) {
      ChatApi chatApi = ChatApi.fromJson(value.data() as Map<String, dynamic>);
      chatApi = chatApi.copyWith(idChat: value.id);
      return chatApi;
    });

    _convertSimpleApiToDto(chatApi);
  }

  Future<String> anyChatUser(String idUser, String idOtherUser) async {
    log('GET -- ANY CHAT USER');

    CollectionReference chatsReference = _db.collection(COLLECTION_NAME);

    QuerySnapshot query = await chatsReference.where('anfitriones', arrayContainsAny: [idUser, idOtherUser]).where('nombreEvento', isNull: true).get();

    return query.docs.isEmpty ? '' : query.docs.first.id;
  }

  // =============
  // POST
  // =============
  Future<String> saveChat(ChatApi chatApi) async {
    log('POST -- SAVE CHAT');

    DocumentReference documentReference = _db.collection(COLLECTION_NAME).doc();

    await documentReference.set(chatApi.toJson());

    getChats();

    return documentReference.id;
  }

  // =============
  // PUT
  // =============
  Future<void> updateMessage(ChatDto chatDto, String mensaje, String idUser) async {
    log('PUT -- UPDATE MESSAGE');

    ChatApi chatApi = ChatApi(
      anfitriones: chatDto.anfitriones.map((e) => e.idUser).toList(),
      datosEvento: chatDto.datosEvento,
      fotoEvento: chatDto.fotoEvento,
      nombreEvento: chatDto.nombreEvento,
      idChat: chatDto.idChat,
      mensajes: chatDto.mensajes
          .map((e) => MensajeApi(
                editor: e.editor.idUser,
                mensaje: e.mensaje,
                creacion: e.creacion,
              ))
          .toList(),
    );

    MensajeApi newMensaje = MensajeApi(
      editor: idUser,
      mensaje: mensaje,
      creacion: DateTime.now(),
    );

    chatApi.mensajes.add(newMensaje);

    // Usuario principal
    await _db.collection(COLLECTION_NAME).doc(chatApi.idChat).update(chatApi.toJson());

    getChats();
  }
}
