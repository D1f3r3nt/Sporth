import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sporth/models/models.dart';
import 'package:flutter/services.dart' show rootBundle;

class DeportesProvider extends ChangeNotifier {
  List<DeportesLocal> deportes = [];
  List<DeportesDto> deportesSelect = [];
  List<DeportesDto> deportesFilter = [];

  DeportesProvider() {
    getData();
  }

  getData() async {
    log('GET_LOCAL_DEPORTES');
    final response = await rootBundle.loadString('data/deportes.json');
    List dataMap = json.decode(response);

    dataMap.forEach((value) => deportes.add(DeportesLocal.fromMap(value)));
    notifyListeners();
    log('CORRECT - GET_LOCAL_DEPORTES');
    dataToSelect();
  }

  Future<List<DeportesLocal>> getDataCurrent() async {
    List<DeportesLocal> returnment = [];
    final response = await rootBundle.loadString('data/deportes.json');
    List dataMap = json.decode(response);

    dataMap.forEach((value) => returnment.add(DeportesLocal.fromMap(value)));
    return returnment;
  }

  dataToSelect() {
    deportesSelect = deportes
        .map((element) => DeportesDto(
              id: element.id,
              imagen: element.imagen,
              nombre: element.nombre,
              selected: false,
            ))
        .toList();

    deportesFilter = deportesSelect;
    notifyListeners();
  }
}
