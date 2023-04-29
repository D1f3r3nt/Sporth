import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';

class ChatProvider extends ChangeNotifier {
  final DatabaseChat databaseChat = DatabaseChat();

  List<ChatDto> chats = [];
  List<MensajeDto> mensajes = [];

  void getChats() async {
    if (chats.isNotEmpty) return;
    List<ChatApi> listChats = await databaseChat.getChats();
    chats = await ChatMapper.INSTANCE.listChatApiToListChatDto(listChats);
    notifyListeners();
  }

  void getChat(String idChat) async {
    List<MensajeApi> list = await databaseChat.getChat(idChat);
    mensajes =
        await MensajeMapper.INSTANCE.listMensajeApiToListMensajeDto(list);
    mensajes.sort((a, b) => a.creacion.compareTo(b.creacion));
    mensajes = mensajes.reversed.toList();
    notifyListeners();
  }

  Future<String> anyChatUser(String idUser, String idOtherUser) async {
    return await databaseChat.anyChatUser(idUser, idOtherUser);
  }

  Future<String> saveChat(ChatApi newChat) async {
    return await databaseChat.saveChat(newChat);
  }

  void sendMessage(String idChat, String mensaje, String idUser) async {
    await databaseChat.updateMessage(idChat, mensaje, idUser);
  }
}
