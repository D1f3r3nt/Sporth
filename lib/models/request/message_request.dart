import 'dart:convert';

import 'package:sporth/models/request/user_request.dart';

MessageRequest messageRequestFromJson(String str) => MessageRequest.fromJson(json.decode(str));

String messageRequestToJson(MessageRequest data) => json.encode(data.toJson());

class MessageRequest {
  final UserRequest editor;
  final DateTime creacion;
  final String mensaje;

  MessageRequest({
    required this.editor,
    required this.creacion,
    required this.mensaje,
  });

  MessageRequest copyWith({
    UserRequest? editor,
    DateTime? creacion,
    String? mensaje,
  }) =>
      MessageRequest(
        editor: editor ?? this.editor,
        creacion: creacion ?? this.creacion,
        mensaje: mensaje ?? this.mensaje,
      );

  factory MessageRequest.fromJson(Map<String, dynamic> json) => MessageRequest(
    editor: UserRequest.fromJson(json["editor"]),
    creacion: DateTime.fromMicrosecondsSinceEpoch(json["creacion"].microsecondsSinceEpoch),
    mensaje: json["mensaje"],
  );

  Map<String, dynamic> toJson() => {
    "editor": editor.toJson(),
    "creacion": creacion,
    "mensaje": mensaje,
  };
}

