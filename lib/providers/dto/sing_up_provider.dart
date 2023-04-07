import 'dart:developer';

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
    seguidores: 0,
    seguidos: [],
    telefono: '',
    username: '',
  );

  void addDatos(String email, String usuario, String uid) {
    log('ADD_DATOS');
    newUser = newUser.copyOf(email: email, username: usuario, idUser: uid);
    notifyListeners();
    log('CORRECT - ADD_DATOS');
  }

  void addPersonal(String nombre, String apellidos, String imagen, DateTime nacimiento, String telefono) {
    log('ADD_PERSONAL');
    newUser = newUser.copyOf(
      nombre: nombre,
      apellidos: apellidos,
      imagen: imagen,
      nacimiento: nacimiento,
      telefono: telefono,
    );
    notifyListeners();
    log('CORRECT - ADD_PERSONAL');
  }

  void addGustos(List<DeportesDto> gustos) {
    log('ADD_GUSTOS');
    newUser = newUser.copyOf(gustos: gustos.map((e) => e.id).toList());
    log('CORRECT - ADD_GUSTOS');
  }
}
