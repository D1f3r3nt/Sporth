import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sporth/models/dto/search_dto.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/firebase/database/database_evento.dart';

class EventosProvider extends ChangeNotifier {
  final databaseEvento = DatabaseEvento();
  List<EventoDto> allEventos = [];
  List<EventoDto> filteredEventos = [];

  Future<void> refresh() async {
    allEventos = [];
    notifyListeners();
  }

  void getAllEventosOneTime() async {
    log('GET_ALL_EVENTOS');
    final oldList = allEventos;
    allEventos = await databaseEvento.getAllEventos();

    if (oldList.isEmpty) notifyListeners();

    log('CORRECT - GET_ALL_EVENTOS');
  }

  void getFilteredEventosOneTime(SearchDto searchDto) async {
    log('GET_FILTERED_EVENTOS');
    final oldList = filteredEventos;
    filteredEventos = await databaseEvento.getFilterEventos(searchDto);

    if (oldList.isEmpty) notifyListeners();

    log('CORRECT - GET_FILTERED_EVENTOS');
  }
}
