import 'package:sporth/models/local/deportes_local.dart';

class UserLocal {
  final int idUser;
  final String nombre;
  final String apellidos;
  final String username;
  final String imagen;
  final List<DeportesLocal> gustos;
  final DateTime nacimiento;
  final String telefono;
  final String email;
  final List<int> logros;
  final List<UserLocal> seguidos;
  final int seguidores;

  UserLocal(
    this.idUser,
    this.nombre,
    this.apellidos,
    this.username,
    this.imagen,
    this.gustos,
    this.nacimiento,
    this.telefono,
    this.email,
    this.logros,
    this.seguidos,
    this.seguidores,
  );
}
