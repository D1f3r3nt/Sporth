import 'dart:convert';

class DeportesAsset {
  DeportesAsset({
    required this.id,
    required this.imagen,
    required this.nombre,
    required this.players,
  });

  int id;
  String imagen;
  String nombre;
  int players;

  factory DeportesAsset.fromJson(String str) => DeportesAsset.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeportesAsset.fromMap(Map<String, dynamic> json) => DeportesAsset(
        id: json["id"],
        imagen: json["imagen"],
        nombre: json["nombre"],
        players: json["players"]
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "imagen": imagen,
        "nombre": nombre,
        "players": players
      };
}
