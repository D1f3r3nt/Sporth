import 'dart:convert';

class UserRequest {
  final String idUser;
  final String imagen;
  final List<int> gustos;
  final String telefono;
  final String nombre;
  final String email;
  final DateTime nacimiento;
  final String username;
  final List<String> seguidos;
  final List<int> logros;
  final List<String> seguidores;

  UserRequest({
    required this.idUser,
    required this.imagen,
    required this.gustos,
    required this.telefono,
    required this.nombre,
    required this.email,
    required this.nacimiento,
    required this.username,
    required this.seguidos,
    required this.logros,
    required this.seguidores,
  });
  
  UserRequest.only({
    required this.idUser,
    required this.nacimiento,
    this.imagen = '',
    this.gustos = const [],
    this.nombre = '',
    this.username = '',
    this.logros = const [],
    this.email = '',
    this.seguidores = const [],
    this.seguidos = const [],
    this.telefono = ''
  });

  UserRequest copyWith({
    String? idUser,
    String? imagen,
    List<int>? gustos,
    String? telefono,
    String? nombre,
    String? email,
    DateTime? nacimiento,
    String? username,
    List<String>? seguidos,
    List<int>? logros,
    List<String>? seguidores,
  }) =>
      UserRequest(
        idUser: idUser ?? this.idUser,
        imagen: imagen ?? this.imagen,
        gustos: gustos ?? this.gustos,
        telefono: telefono ?? this.telefono,
        nombre: nombre ?? this.nombre,
        email: email ?? this.email,
        nacimiento: nacimiento ?? this.nacimiento,
        username: username ?? this.username,
        seguidos: seguidos ?? this.seguidos,
        logros: logros ?? this.logros,
        seguidores: seguidores ?? this.seguidores,
      );

  factory UserRequest.fromRawJson(String str) => UserRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
    idUser: json["idUser"],
    imagen: json["imagen"],
    gustos: List<int>.from(json["gustos"].map((x) => x)),
    telefono: json["telefono"],
    nombre: json["nombre"],
    email: json["email"],
    nacimiento: DateTime.fromMillisecondsSinceEpoch(json["nacimiento"]["_seconds"] * 1000),
    username: json["username"],
    seguidos: List<String>.from(json["seguidos"].map((x) => x)),
    logros: List<int>.from(json["logros"].map((x) => x)),
    seguidores: List<String>.from(json["seguidores"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "idUser": idUser,
    "imagen": imagen,
    "gustos": List<dynamic>.from(gustos.map((x) => x)),
    "telefono": telefono,
    "nombre": nombre,
    "email": email,
    "nacimiento": nacimiento,
    "username": username,
    "seguidos": List<dynamic>.from(seguidos.map((x) => x)),
    "logros": List<dynamic>.from(logros.map((x) => x)),
    "seguidores": List<dynamic>.from(seguidores.map((x) => x)),
  };

  String get urlImagen {
    if (imagen.isEmpty) return 'https://firebasestorage.googleapis.com/v0/b/sporth-c3c47.appspot.com/o/user.png?alt=media&token=7ad26cc5-02f3-4160-8802-eecd875ac101';
    return imagen;
  }
}