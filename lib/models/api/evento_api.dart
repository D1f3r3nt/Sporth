import 'dart:convert';

import 'package:intl/intl.dart';

import 'package:sporth/models/dto/geografico_dto.dart';

EventoApi eventoDtoFromJson(String str) => EventoApi.fromJson(json.decode(str));

String eventoDtoToJson(EventoApi data) => json.encode(data.toJson());

class EventoApi {
  EventoApi({
    required this.name,
    required this.hora,
    required this.dia,
    required this.ubicacion,
    required this.precio,
    required this.maximo,
    required this.deporte,
    required this.imagen,
    required this.descripcion,
    required this.anfitrion,
    required this.participantes,
    required this.geo,
    this.privado,
  });

  String name;
  DateTime hora;
  DateTime dia;
  String ubicacion;
  int precio;
  int maximo;
  int deporte;
  String imagen;
  String descripcion;
  String anfitrion;
  List<String> participantes;
  GeograficoDto geo;
  String? privado;

  factory EventoApi.fromJson(Map<String, dynamic> json) => EventoApi(
        name: json["name"],
        hora: DateFormat.Hm().parse(json["hora"]),
        dia: DateFormat.yMd().parse(json["dia"]),
        ubicacion: json["ubicacion"],
        precio: json["precio"],
        maximo: json["maximo"],
        deporte: json["deporte"],
        imagen: json["imagen"],
        descripcion: json["descripcion"],
        anfitrion: json["anfitrion"],
        participantes: List<String>.from(json["participantes"].map((x) => x)),
        geo: GeograficoDto.fromString(json["geo"]),
        privado: json["privado"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "hora": DateFormat.Hm().format(hora),
        "dia": DateFormat.yMd().format(dia),
        "ubicacion": ubicacion,
        "precio": precio,
        "maximo": maximo,
        "deporte": deporte,
        "imagen": imagen,
        "descripcion": descripcion,
        "anfitrion": anfitrion,
        "participantes": List<dynamic>.from(participantes.map((x) => x)),
        "geo": geo.toString(),
        "privado": privado,
      };

  String get diaFormat {
    return DateFormat('dd MMM').format(dia);
  }

  String get timeFormat {
    return DateFormat.Hm().format(hora);
  }
}
