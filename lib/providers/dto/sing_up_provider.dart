import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';

class SingUpProvider extends ChangeNotifier {
  UserDto newUser = UserDto(
    apellidos: '',
    email: '',
    gustos: [],
    idUser: '',
    imagen: '',
    logros: [],
    nacimiento: DateTime.now(),
    nombre: '',
    seguidores: [],
    seguidos: [],
    telefono: '',
    username: '',
  );

  void addDatos(String email, String usuario, String uid) {
    newUser = newUser.copyOf(email: email, username: usuario, idUser: uid);
    notifyListeners();
  }

  void addPersonal(String nombre, String apellidos, String imagen, DateTime nacimiento, String telefono) {
    newUser = newUser.copyOf(
      nombre: nombre,
      apellidos: apellidos,
      imagen: imagen,
      nacimiento: nacimiento,
      telefono: telefono,
    );
    notifyListeners();
  }

  void addGustos(List<DeportesDto> gustos) {
    newUser = newUser.copyOf(gustos: gustos.map((e) => e.id).toList());
  }
}
