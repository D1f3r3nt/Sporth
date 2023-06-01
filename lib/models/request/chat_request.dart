import 'dart:convert';

import 'package:sporth/models/models.dart';

ChatRequest chatRequestFromJson(String str) => ChatRequest.fromJson(json.decode(str));

String chatRequestToJson(ChatRequest data) => json.encode(data.toJson());

class ChatRequest {
  final List<UserRequest> anfitriones;
  final String? idEvent;
  final String? idChat;

  ChatRequest({
    required this.anfitriones,
    this.idChat,
    this.idEvent,
  });

  ChatRequest copyWith({
    List<UserRequest>? anfitriones,
    String? idEvent,
    String? idChat,
  }) =>
      ChatRequest(
        anfitriones: anfitriones ?? this.anfitriones,
        idEvent: idEvent ?? this.idEvent,
        idChat: idChat ?? this.idChat,
      );

  factory ChatRequest.fromRawJson(String str) => ChatRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatRequest.fromJson(Map<String, dynamic> json) => ChatRequest(
    anfitriones: List<UserRequest>.from(json["anfitriones"].map((x) => UserRequest.fromJson(x))),
    idEvent: json["idEvent"],
    idChat: json["idChat"],
  );

  Map<String, dynamic> toJson() => {
    "anfitriones": List<dynamic>.from(anfitriones.map((x) => x.idUser)),
    "idEvent": idEvent,
    "idChat": idChat,
  };

  UserRequest getOtherAnfitrion(String idUser) {
    return anfitriones
        .where((element) => element.idUser != idUser)
        .toList()
        .first;
  }
}
