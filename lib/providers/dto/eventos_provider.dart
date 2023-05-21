import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/service/service.dart';
import 'package:sporth/repository/event_repository.dart';

class EventosProvider extends ChangeNotifier {
  final EventRepository _eventService = EventRepository();
  final LogrosService _logrosProviderImpl = LogrosService();
  final PositionService _positionService = PositionService();

  EventRequest? eventoChat;

  Future<List<EventRequest>> getAllEvents(BuildContext context) async {
    UserRequest currentUser = Provider.of<UserProvider>(context).currentUser!;
    List<EventRequest> listEvents = await _eventService.getAllEvents();
    
    bool isEnabled = await _positionService.isEnabled();
    GeograficoDto? geo;
    if (isEnabled) geo = await _positionService.getPosition(context);
    
    listEvents.sort((a, b) {
      int compare = _seguidosComparision(currentUser, a, b);
      
      if (compare != 0) {
        return compare;
      }
      
      if (geo != null) {
        compare = _ubicacion(geo, a, b);
      }
      
      return compare;
    });
    
    return listEvents;
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

  int _seguidosComparision(UserRequest currentUser, EventRequest a, EventRequest b) {
    bool flagA = _isFollowers(currentUser, a);
    bool flagB = _isFollowers(currentUser, b);

    if (flagA && !flagB) {
      return 1;
    } else if (!flagA && flagB) {
      return -1;
    } else {
      return 0;
    }
  }
  
  int _ubicacion(GeograficoDto geo, EventRequest a, EventRequest b) {
    double distanceA = Geolocator.distanceBetween(geo.lat, geo.lng, a.geo.lat, a.geo.lng);
    double distanceB = Geolocator.distanceBetween(geo.lat, geo.lng, b.geo.lat, b.geo.lng);

    if (distanceA > distanceB) return 1;
    if (distanceA < distanceB) return -1;
    return 0;
  }

  bool _isFollowers(UserRequest currentUser, EventRequest a) => currentUser.seguidos.contains(a.anfitrion.idUser);
}
