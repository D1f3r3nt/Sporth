import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:sporth/models/models.dart';

class DeportesProvider extends ChangeNotifier {
  List<DeportesLocal> deportes = [];
  List<DeportesDto> deportesGustos = [];
  List<DeportesDto> deportesFilter = [];
  List<DeportesDto> deportesAdd = [];

  DeportesProvider() {
    getData();
  }

  getData() async {
    final String response = await rootBundle.loadString('data/deportes.json');
    List dataMap = json.decode(response);

    for (var value in dataMap) {
      deportes.add(DeportesLocal.fromMap(value));
    }

    notifyListeners();
    dataToSelect();
  }

  Future<List<DeportesLocal>> getDataCurrent() async {
    List<DeportesLocal> returnment = [];
    final String response = await rootBundle.loadString('data/deportes.json');
    List dataMap = json.decode(response);

    for (var value in dataMap) {
      returnment.add(DeportesLocal.fromMap(value));
    }
    return returnment;
  }

  dataToSelect() {
    deportesGustos = deportes
        .map((element) => DeportesDto(
              id: element.id,
              imagen: element.imagen,
              nombre: element.nombre,
              selected: false,
            ))
        .toList();

    deportesFilter = deportesGustos.map((e) => e.copyOf()).toList();
    deportesAdd = deportesGustos.map((e) => e.copyOf()).toList();
    notifyListeners();
  }
}
