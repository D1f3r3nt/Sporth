import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sporth/models/models.dart';
import 'package:flutter/services.dart' show rootBundle;

class DeportesProvider extends ChangeNotifier {
  List<DeportesLocal> deportes = [];
  List<DeportesDto> deportesSelect = [];

  DeportesProvider() {
    getData();
  }

  getData() async {
    final response = await rootBundle.loadString('data/deportes.json');
    List dataMap = json.decode(response);

    dataMap.forEach((value) => deportes.add(DeportesLocal.fromMap(value)));
    notifyListeners();
    dataToSelect();
  }

  dataToSelect() {
    deportesSelect = deportes
        .map((element) => DeportesDto(
              imagen: element.imagen,
              nombre: element.nombre,
              selected: false,
            ))
        .toList();
    notifyListeners();
  }
}
