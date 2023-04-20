import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';

class EventosProvider extends ChangeNotifier {
  final DatabaseEvento databaseEvento = DatabaseEvento();

  List<EventoDto> allEvents = [];
  List<EventoDto> filteredEventos = [];

  Future<void> refresh() async {
    allEvents = await databaseEvento.importantAllEvents;
    notifyListeners();
  }

  void getAllEventos() async {
    allEvents = await databaseEvento.allEvents;
    notifyListeners();
  }

  void getFilteredEventos(SearchDto searchDto) async {
    filteredEventos = await databaseEvento.getFilterEventos(searchDto);
    notifyListeners();
  }
}
