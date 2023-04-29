import 'dart:convert';

class DeportesAsset {
  DeportesAsset({
    required this.id,
    required this.imagen,
    required this.nombre,
  });

  int id;
  String imagen;
  String nombre;

  factory DeportesAsset.fromJson(String str) => DeportesAsset.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeportesAsset.fromMap(Map<String, dynamic> json) => DeportesAsset(
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
