import 'dart:convert';

import 'package:sporth/models/models.dart';

ChatApi chatDtoFromJson(String str) => ChatApi.fromJson(json.decode(str));

String chatDtoToJson(ChatApi data) => json.encode(data.toJson());

class ChatApi {
  ChatApi({
    this.idChat,
    required this.anfitriones,
    this.nombreEvento,
    this.fotoEvento,
    this.datosEvento,
    required this.mensajes,
  });

  final String? idChat;
  final List<String> anfitriones;
  final String? nombreEvento;
  final String? fotoEvento;
  final String? datosEvento;
  final List<MensajeApi> mensajes;

  ChatApi copyWith({
    String? idChat,
    List<String>? anfitriones,
    String? nombreEvento,
    String? fotoEvento,
    String? datosEvento,
    List<MensajeApi>? mensajes,
  }) =>
      ChatApi(
        idChat: idChat ?? this.idChat,
        anfitriones: anfitriones ?? this.anfitriones,
        nombreEvento: nombreEvento ?? this.nombreEvento,
        fotoEvento: fotoEvento ?? this.fotoEvento,
        datosEvento: datosEvento ?? this.datosEvento,
        mensajes: mensajes ?? this.mensajes,
      );

  factory ChatApi.fromJson(Map<String, dynamic> json) => ChatApi(
        anfitriones: List<String>.from(json["anfitriones"].map((x) => x)),
        nombreEvento: json["nombreEvento"],
        fotoEvento: json["fotoEvento"],
        datosEvento: json["datosEvento"],
        mensajes: List<MensajeApi>.from(json["mensajes"].map((x) => MensajeApi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "anfitriones": List<dynamic>.from(anfitriones.map((x) => x)),
        "nombreEvento": nombreEvento,
        "fotoEvento": fotoEvento,
        "datosEvento": datosEvento,
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
      };
}
