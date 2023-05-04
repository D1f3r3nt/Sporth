import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/dto/logros_provider_impl.dart';
import 'package:sporth/providers/providers.dart';

class EventosProvider extends ChangeNotifier {
  final DatabaseEvento _databaseEvento = DatabaseEvento();
  final LogrosProviderImpl _logrosProviderImpl = LogrosProviderImpl();

  List<EventoDto> allEvents = [];
  List<EventoDto> filteredEventos = [];
  List<EventoDto> eventsByUser = [];
  EventoDto? eventoChat;

  Future<void> refresh() async {
    allEvents = await _databaseEvento.getAllEventos();
    notifyListeners();
  }

  void getAllEventos() async {
    if (allEvents.isEmpty) {
      allEvents = await _databaseEvento.getAllEventos();
    }
    notifyListeners();
  }
  
  void getEventosByUser(String idUser) async {
    eventsByUser = await _databaseEvento.getEventsDtoByAnfitrion(idUser);
    notifyListeners();
  }

  void getFilteredEventos(SearchDto searchDto) async {
    filteredEventos = await _databaseEvento.getFilterEventos(searchDto);
    notifyListeners();
  }

  Future<EventoDto> getEvento(String idEvento) async {
    EventoApi eventoApi = await _databaseEvento.getEvento(idEvento);
    return await EventoMapper.INSTANCE
        .eventoApiToEventoDto(idEvento, eventoApi);
  }

  Future<void> inscribe(String idEvento, String idUser) async {
    await _databaseEvento.inscribe(idEvento, idUser);
  }

  Future<void> saveEvento(EventoApi evento, UserDto user) async {
    await _databaseEvento.saveEvento(evento);
    await _logrosProviderImpl.getEventLogro(user);
  }
}
