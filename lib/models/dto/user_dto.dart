import 'dart:convert';

class UserDto {
  final String idUser;
  final String nombre;
  final String apellidos;
  final String username;
  final String imagen;
  final List<int> gustos;
  final DateTime nacimiento;
  final String telefono;
  final String email;
  final List<int> logros;
  final List<String> seguidos;
  final List<String> seguidores;

  UserDto({
    required this.idUser,
    required this.nombre,
    required this.apellidos,
    required this.username,
    required this.imagen,
    required this.gustos,
    required this.nacimiento,
    required this.telefono,
    required this.email,
    required this.logros,
    required this.seguidos,
    required this.seguidores,
  });

  UserDto copyOf({
    String? idUser,
    String? nombre,
    String? apellidos,
    String? username,
    String? imagen,
    List<int>? gustos,
    DateTime? nacimiento,
    String? telefono,
    String? email,
    List<int>? logros,
    List<String>? seguidos,
    List<String>? seguidores,
  }) {
    return UserDto(
      idUser: idUser ?? this.idUser,
      nombre: nombre ?? this.nombre,
      apellidos: apellidos ?? this.apellidos,
      username: username ?? this.username,
      imagen: imagen ?? this.imagen,
      gustos: gustos ?? this.gustos,
      nacimiento: nacimiento ?? this.nacimiento,
      telefono: telefono ?? this.telefono,
      email: email ?? this.email,
      logros: logros ?? this.logros,
      seguidos: seguidos ?? this.seguidos,
      seguidores: seguidores ?? this.seguidores,
    );
  }

  String get urlImagen {
    if (imagen.isEmpty) return 'https://firebasestorage.googleapis.com/v0/b/sporth-c3c47.appspot.com/o/user.png?alt=media&token=7ad26cc5-02f3-4160-8802-eecd875ac101';
    return imagen;
  }

  factory UserDto.fromJson(String str) => UserDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserDto.fromMap(Map<String, dynamic> json) => UserDto(
        imagen: json["imagen"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        email: json["email"],
        gustos: List<int>.from(json["gustos"].map((x) => x)),
        idUser: json["idUser"],
        logros: List<int>.from(json["logros"].map((x) => x)),
        nacimiento: DateTime.fromMicrosecondsSinceEpoch(json["nacimiento"].microsecondsSinceEpoch),
        seguidores: List<String>.from(json["seguidores"].map((x) => x)),
        seguidos: List<String>.from(json["seguidos"].map((x) => x)),
        telefono: json["telefono"],
        username: json["username"],
      );

  Map<String, dynamic> toMap() => {
        "imagen": imagen,
        "nombre": nombre,
        "apellidos": apellidos,
        "email": email,
        "gustos": List<dynamic>.from(gustos.map((x) => x)),
        "idUser": idUser,
        "logros": List<dynamic>.from(logros.map((x) => x)),
        "nacimiento": nacimiento,
        "seguidores": List<dynamic>.from(seguidores.map((x) => x)),
        "seguidos": List<dynamic>.from(seguidos.map((x) => x)),
        "telefono": telefono,
        "username": username,
      };
}
