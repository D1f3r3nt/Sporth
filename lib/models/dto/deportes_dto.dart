import 'package:meta/meta.dart';
import 'dart:convert';

class DeportesDto {
  DeportesDto({
    required this.id,
    required this.imagen,
    required this.nombre,
    required this.selected,
  });

  int id;
  String imagen;
  String nombre;
  bool selected;

  factory DeportesDto.fromJson(String str) => DeportesDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeportesDto.fromMap(Map<String, dynamic> json) => DeportesDto(
        id: json["id"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        selected: json["selected"] == 1,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "imagen": imagen,
        "nombre": nombre,
        "selected": selected,
      };

  DeportesDto copyOf({
    int? id,
    String? nombre,
    String? imagen,
    bool? selected,
  }) {
    return DeportesDto(
      id: id ?? this.id,
      imagen: imagen ?? this.imagen,
      nombre: nombre ?? this.nombre,
      selected: selected ?? this.selected,
    );
  }
}
