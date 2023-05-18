import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/service/ui/logros_service.dart';
import 'package:sporth/repository/event_repository.dart';

class EventosProvider extends ChangeNotifier {
  final EventRepository _eventService = EventRepository();
  final LogrosService _logrosProviderImpl = LogrosService();

  EventRequest? eventoChat;

  Future<List<EventRequest>> getAllEvents() async {
      return await _eventService.getAllEvents();
  }

  Future<List<EventRequest>> getEventsByUser(String idUser) async {
    return await _eventService.getEventsByAnfitrion(idUser);
  }

  Future<List<EventRequest>> getFilteredEvents(SearchDto searchDto) async {
    return await _eventService.getFilterEvents(searchDto);
  }

  Future<EventRequest> getEvent(String idEvento) async {
    return await _eventService.getEvent(idEvento);
  }

  Future<void> inscribe(String idEvento, String idUser) async {
    await _eventService.inscribe(idEvento, idUser);
  }

  Future<void> saveEvent(EventRequest evento, UserRequest user) async {
    await _eventService.saveEvent(evento);
    await _logrosProviderImpl.getEventLogro(user);
  }
}
