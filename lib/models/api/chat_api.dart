import 'dart:convert';

ChatApi chatDtoFromJson(String str) => ChatApi.fromJson(json.decode(str));

String chatDtoToJson(ChatApi data) => json.encode(data.toJson());

class ChatApi {
  ChatApi({
    this.idChat,
    required this.anfitriones,
    this.idEvent,
  });

  final String? idChat;
  final List<String> anfitriones;
  final String? idEvent;

  ChatApi copyWith({
    String? idChat,
    String? idEvent,
    List<String>? anfitriones,
  }) =>
      ChatApi(
        idChat: idChat ?? this.idChat,
        anfitriones: anfitriones ?? this.anfitriones,
        idEvent: idEvent ?? this.idEvent,
      );

  factory ChatApi.fromJson(Map<String, dynamic> json) => ChatApi(
        anfitriones: List<String>.from(json["anfitriones"].map((x) => x)),
        idEvent: json["idEvent"],
      );

  Map<String, dynamic> toJson() => {
        "anfitriones": List<dynamic>.from(anfitriones.map((x) => x)),
        "idEvent": idEvent,
      };
}
