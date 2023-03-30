import 'package:meta/meta.dart';
import 'dart:convert';

class DeportesLocal {
  DeportesLocal({
    required this.imagen,
    required this.nombre,
  });

  String imagen;
  String nombre;

  factory DeportesLocal.fromJson(String str) =>
      DeportesLocal.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeportesLocal.fromMap(Map<String, dynamic> json) => DeportesLocal(
        imagen: json["imagen"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toMap() => {
        "imagen": imagen,
        "nombre": nombre,
      };
}
