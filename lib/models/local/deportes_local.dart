import 'package:meta/meta.dart';
import 'dart:convert';

class DeportesLocal {
  DeportesLocal({
    required this.id,
    required this.imagen,
    required this.nombre,
  });

  int id;
  String imagen;
  String nombre;

  factory DeportesLocal.fromJson(String str) => DeportesLocal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeportesLocal.fromMap(Map<String, dynamic> json) => DeportesLocal(
        id: json["id"],
        imagen: json["imagen"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "imagen": imagen,
        "nombre": nombre,
      };
}
