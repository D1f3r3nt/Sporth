import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/dto/logros_provider_impl.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/trasnform_utils.dart';

class ChatProvider extends ChangeNotifier {
  final DatabaseChat databaseChat = DatabaseChat();
  final LogrosProviderImpl _logrosProviderImpl = LogrosProviderImpl();

  List<ChatDto> chats = [];
  List<MensajeDto> mensajes = [];

  void getChats() async {
    if (chats.isNotEmpty) return;
    List<ChatApi> listChats = await databaseChat.getChats();
    chats = await ChatMapper.INSTANCE.listChatApiToListChatDto(listChats);
    notifyListeners();
  }

  void refresh() async {
    List<ChatApi> listChats = await databaseChat.getChats();
    chats = await ChatMapper.INSTANCE.listChatApiToListChatDto(listChats);
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMensajes(String idChat) async* {
    yield* FirebaseFirestore.instance
        .collection('chats/$idChat/mensajes')
        .orderBy('creacion', descending: true)
        .snapshots();
  }

  Future<ChatApi?> getChatByEvent(String idEvent) async {
    return await databaseChat.getChatByEvent(idEvent);

    //return chatApi == null ? null : ChatMapper.INSTANCE.chatApiToChatDto(chatApi);
  }

  Future<String> anyChatUser(String idUser, String idOtherUser) async {
    return await databaseChat.anyChatUser(idUser, idOtherUser);
  }

  Future<String> saveChat(ChatApi newChat) async {
    return await databaseChat.saveChat(newChat);
  }

  Future<void> updateChat(ChatApi chatApi) async {
    await databaseChat.updateChat(chatApi);
  }

  void sendMessage(String idChat, String mensaje, UserDto user) async {
    await databaseChat.updateMessage(idChat, mensaje, user.idUser);
    await _logrosProviderImpl.getChatLogro(user);
  }
}
