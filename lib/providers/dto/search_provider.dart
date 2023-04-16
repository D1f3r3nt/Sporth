import 'package:flutter/material.dart';
import 'package:sporth/models/dto/search_dto.dart';

class SearchProvider extends ChangeNotifier {
  SearchDto _searchDto = SearchDto();

  SearchDto get search {
    return _searchDto;
  }

  set deporte(List<int>? deporte) {
    _searchDto = _searchDto.copyOf(deporte: deporte);
    notifyListeners();
  }

  set nombre(String? nombre) {
    _searchDto = _searchDto.copyOf(nombre: nombre);
    notifyListeners();
  }

  set hora(String? hora) {
    _searchDto = _searchDto.copyOf(hora: hora);
    notifyListeners();
  }

  set dia(String? dia) {
    _searchDto = _searchDto.copyOf(dia: dia);
    notifyListeners();
  }

  set maxPersonas(int maxPersonas) {
    _searchDto = _searchDto.copyOf(maxPersonas: maxPersonas);
    notifyListeners();
  }

  set precio(int precio) {
    _searchDto = _searchDto.copyOf(precio: precio);
    notifyListeners();
  }
}
