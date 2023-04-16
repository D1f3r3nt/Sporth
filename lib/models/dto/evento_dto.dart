import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sporth/models/models.dart';

class EventoDto {
  EventoDto({
    required this.id,
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

  String id;
  String name;
  DateTime hora;
  DateTime dia;
  String ubicacion;
  int precio;
  int maximo;
  DeportesLocal deporte;
  String imagen;
  String descripcion;
  UserDto anfitrion;
  List<UserDto> participantes;
  String? privado;

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
