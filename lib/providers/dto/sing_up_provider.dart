import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';

class SingUpProvider extends ChangeNotifier {
  UserRequest newUser = UserRequest.only(idUser: '', nacimiento: DateTime.now());

  void addDatos(String email, String usuario, String uid) {
    newUser = newUser.copyWith(email: email, username: usuario, idUser: uid);
    notifyListeners();
  }
  
  void addUsername(String usuario) {
    newUser = newUser.copyWith(username: usuario);
    notifyListeners();
  }

  void addPersonal(String nombre, String apellidos, String imagen, DateTime nacimiento, String telefono) {
    newUser = newUser.copyWith(
      nombre: '$nombre $apellidos',
      imagen: imagen,
      nacimiento: nacimiento,
      telefono: telefono,
    );
    notifyListeners();
  }

  void addGustos(List<DeportesDto> gustos) {
    newUser = newUser.copyWith(gustos: gustos.map((e) => e.id).toList());
  }
}
