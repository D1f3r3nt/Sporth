import 'dart:convert';

import 'package:sporth/models/request/user_request.dart';

EventRequest eventRequestFromJson(String str) => EventRequest.fromJson(json.decode(str));

String eventRequestToJson(EventRequest data) => json.encode(data.toJson());

class EventRequest {
  final String? id;
  final String descripcion;
  final String ubicacion;
  final int deporte;
  final String hora;
  final int maximo;
  final String imagen;
  final String geo;
  final int precio;
  final UserRequest anfitrion;
  final String name;
  final dynamic privado;
  final String dia;
  final List<UserRequest> participantes;

  EventRequest({
    this.id,
    required this.descripcion,
    required this.ubicacion,
    required this.deporte,
    required this.hora,
    required this.maximo,
    required this.imagen,
    required this.geo,
    required this.precio,
    required this.anfitrion,
    required this.name,
    required this.privado,
    required this.dia,
    required this.participantes,
  });

  EventRequest copyWith({
    String? id,
    String? descripcion,
    String? ubicacion,
    int? deporte,
    String? hora,
    int? maximo,
    String? imagen,
    String? geo,
    int? precio,
    UserRequest? anfitrion,
    String? name,
    dynamic privado,
    String? dia,
    List<UserRequest>? participantes,
  }) =>
      EventRequest(
        id: id ?? this.id,
        descripcion: descripcion ?? this.descripcion,
        ubicacion: ubicacion ?? this.ubicacion,
        deporte: deporte ?? this.deporte,
        hora: hora ?? this.hora,
        maximo: maximo ?? this.maximo,
        imagen: imagen ?? this.imagen,
        geo: geo ?? this.geo,
        precio: precio ?? this.precio,
        anfitrion: anfitrion ?? this.anfitrion,
        name: name ?? this.name,
        privado: privado ?? this.privado,
        dia: dia ?? this.dia,
        participantes: participantes ?? this.participantes,
      );

  factory EventRequest.fromJson(Map<String, dynamic> json) => EventRequest(
    id: json["id"],
    descripcion: json["descripcion"],
    ubicacion: json["ubicacion"],
    deporte: json["deporte"],
    hora: json["hora"],
    maximo: json["maximo"],
    imagen: json["imagen"],
    geo: json["geo"],
    precio: json["precio"],
    anfitrion: UserRequest.fromJson(json["anfitrion"]),
    name: json["name"],
    privado: json["privado"],
    dia: json["dia"],
    participantes: List<UserRequest>.from(json["participantes"].map((x) => UserRequest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "descripcion": descripcion,
    "ubicacion": ubicacion,
    "deporte": deporte,
    "hora": hora,
    "maximo": maximo,
    "imagen": imagen,
    "geo": geo,
    "precio": precio,
    "anfitrion": anfitrion.idUser,
    "name": name,
    "privado": privado,
    "dia": dia,
    "participantes": List<dynamic>.from(participantes.map((x) => x.idUser)),
  };
}