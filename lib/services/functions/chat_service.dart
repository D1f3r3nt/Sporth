import 'dart:convert';

import 'package:sporth/models/models.dart';
import 'package:sporth/utils/strings.dart';

import 'package:http/http.dart' as http;

class ChatService {
  Future<List<ChatRequest>> getChats() async {
    Uri url = Uri.https(URL_BASE, CHAT_ALL);

    http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    } else {
      List<dynamic> list = json.decode(response.body);
      return list.map((event) => ChatRequest.fromJson(event)).toList();
    }
  }

  Future<ChatRequest?> getChatByEvent(String idEvent) async {
    Uri url = Uri.https(URL_BASE, CHAT_BY_EVENT, {
      'idEvent': idEvent
    });

    http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    } else {
      return response.body.isEmpty ? null : ChatRequest.fromRawJson(response.body);
    }
  }

  Future<String> anyChatUser(String idUser, String idOtherUser) async {
    Uri url = Uri.https(URL_BASE, ANY_CHAT_USER, {
      'idUser': idUser,
      'idOtherUser': idOtherUser,
    });

    http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    } else {
      return response.body;
    }
  }

  Future<void> saveChat(ChatRequest chat) async {
    Uri url = Uri.https(URL_BASE, CHAT_SAVE);

    http.Response response = await http.post(url, body: chat.toRawJson());

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    }
  }

  Future<void> updateChat(ChatRequest chat) async {
    Uri url = Uri.https(URL_BASE, CHAT_UPDATE, {
      'idChat': chat.idChat!,
    });

    http.Response response = await http.post(url, body: chat.toRawJson());

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    }
  }
}