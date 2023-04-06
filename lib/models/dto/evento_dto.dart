import 'dart:convert';

import 'package:flutter/material.dart';

EventoDto eventoDtoFromJson(String str) => EventoDto.fromJson(json.decode(str));

String eventoDtoToJson(EventoDto data) => json.encode(data.toJson());

class EventoDto {
  EventoDto({
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
  String? privado;

  factory EventoDto.fromJson(Map<String, dynamic> json) => EventoDto(
        name: json["name"],
        hora: json["hora"],
        dia: json["dia"],
        ubicacion: json["ubicacion"],
        precio: json["precio"],
        maximo: json["maximo"],
        deporte: json["deporte"],
        imagen: json["imagen"],
        descripcion: json["descripcion"],
        anfitrion: json["anfitrion"],
        participantes: List<String>.from(json["participantes"].map((x) => x)),
        privado: json["privado"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "hora": hora,
        "dia": dia,
        "ubicacion": ubicacion,
        "precio": precio,
        "maximo": maximo,
        "deporte": deporte,
        "imagen": imagen,
        "descripcion": descripcion,
        "anfitrion": anfitrion,
        "participantes": List<dynamic>.from(participantes.map((x) => x)),
        "privado": privado,
      };
}
