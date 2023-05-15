import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:sporth/models/models.dart';

EventRequest eventRequestFromJson(String str) => EventRequest.fromJson(json.decode(str));

String eventRequestToJson(EventRequest data) => json.encode(data.toJson());

class EventRequest {
  final String? id;
  final String descripcion;
  final String ubicacion;
  final int deporte;
  final DateTime hora;
  final int maximo;
  final String imagen;
  final GeograficoDto geo;
  final int precio;
  final UserRequest anfitrion;
  final String name;
  final dynamic privado;
  final DateTime dia;
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
    DateTime? hora,
    int? maximo,
    String? imagen,
    GeograficoDto? geo,
    int? precio,
    UserRequest? anfitrion,
    String? name,
    dynamic privado,
    DateTime? dia,
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

  factory EventRequest.fromRawJson(String str) => EventRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EventRequest.fromJson(Map<String, dynamic> json) => EventRequest(
    id: json["id"],
    descripcion: json["descripcion"],
    ubicacion: json["ubicacion"],
    deporte: json["deporte"],
    hora: DateFormat.Hm().parse(json["hora"]),
    maximo: json["maximo"],
    imagen: json["imagen"],
    geo: GeograficoDto.fromString(json["geo"]),
    precio: json["precio"],
    anfitrion: UserRequest.fromJson(json["anfitrion"]),
    name: json["name"],
    privado: json["privado"],
    dia: DateFormat.yMd().parse(json["dia"]),
    participantes: List<UserRequest>.from(json["participantes"].map((x) => UserRequest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "descripcion": descripcion,
    "ubicacion": ubicacion,
    "deporte": deporte,
    "hora": DateFormat.Hm().format(hora),
    "maximo": maximo,
    "imagen": imagen,
    "geo": geo.toString(),
    "precio": precio,
    "anfitrion": anfitrion.idUser,
    "name": name,
    "privado": privado,
    "dia": DateFormat.yMd().format(dia),
    "participantes": List<dynamic>.from(participantes.map((x) => x.idUser)),
  };

  String get diaFormatShow {
    return DateFormat('dd MMM').format(dia);
  }

  String get month {
    return DateFormat('MMM').format(dia);
  }

  String get diaFormat {
    return DateFormat.yMd().format(dia);
  }

  String get timeFormat {
    return DateFormat.Hm().format(hora);
  }
}