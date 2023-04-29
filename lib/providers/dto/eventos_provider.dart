import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';

class EventosProvider extends ChangeNotifier {
  final DatabaseEvento databaseEvento = DatabaseEvento();

  List<EventoDto> allEvents = [];
  List<EventoDto> filteredEventos = [];
  EventoDto? eventoChat;

  Future<void> refresh() async {
    allEvents = await databaseEvento.getAllEventos();
    notifyListeners();
  }

  void getAllEventos() async {
    if (allEvents.isEmpty) {
      allEvents = await databaseEvento.getAllEventos();
    }
    notifyListeners();
  }

  void getFilteredEventos(SearchDto searchDto) async {
    filteredEventos = await databaseEvento.getFilterEventos(searchDto);
    notifyListeners();
  }

  void getEvento(String idEvento) async {
    EventoApi eventoApi = await databaseEvento.getEvento(idEvento);
    eventoChat =
        await EventoMapper.INSTANCE.eventoApiToEventoDto(idEvento, eventoApi);
    notifyListeners();
  }
}
