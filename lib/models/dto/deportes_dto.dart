import 'package:meta/meta.dart';
import 'dart:convert';

class DeportesDto {
  DeportesDto({
    required this.imagen,
    required this.nombre,
    required this.selected,
  });

  String imagen;
  String nombre;
  bool selected;

  factory DeportesDto.fromJson(String str) =>
      DeportesDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeportesDto.fromMap(Map<String, dynamic> json) => DeportesDto(
        imagen: json["imagen"],
        nombre: json["nombre"],
        selected: json["selected"],
      );

  Map<String, dynamic> toMap() => {
        "imagen": imagen,
        "nombre": nombre,
        "selected": selected,
      };
}
