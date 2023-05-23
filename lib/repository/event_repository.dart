import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:sporth/models/models.dart';
import 'package:sporth/utils/strings.dart';

class EventRepository {
  Future<List<EventRequest>> getFilterEvents(SearchDto searchDto) async {
    List<EventRequest> listResponse = await getAllEvents();

    listResponse = listResponse.where((element) {
      if (element.maximo > searchDto.maxPersonas) return false;
      if (element.precio > searchDto.precio) return false;

      if (searchDto.deporte != null) {
        if (searchDto.deporte!.isNotEmpty) {
          if (!searchDto.deporte!.contains(element.deporte)) return false;
        }
      }

      if (searchDto.nombre != null) {
        if (!element.name
            .toLowerCase()
            .contains(searchDto.nombre!.toLowerCase())) return false;
      }

      if (searchDto.dia != null && searchDto.dia!.isNotEmpty) {
        if (searchDto.dia != element.diaFormat) return false;
      }

      if (searchDto.hora != null && searchDto.hora!.isNotEmpty) {
        if (searchDto.hora != element.timeFormat) return false;
      }

      return true;
    }).toList();

    if (searchDto.ubicacion != null) {
      listResponse.sort((a, b) {
        double distanceA = Geolocator.distanceBetween(searchDto.ubicacion!.lat,
            searchDto.ubicacion!.lng, a.geo.lat, a.geo.lng);
        double distanceB = Geolocator.distanceBetween(searchDto.ubicacion!.lat,
            searchDto.ubicacion!.lng, b.geo.lat, b.geo.lng);

        if (distanceA > distanceB) return 1;
        if (distanceA < distanceB) return -1;
        return 0;
      });
    }

    return listResponse;
  }

  Future<EventRequest> getEvent(String idEvent) async {
    Uri url = Uri.https(URL_BASE, EVENT_ONE, {
      'idEvent': idEvent
    });

    http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    } else {
      return EventRequest.fromRawJson(response.body);
    }
  }

  Future<List<EventRequest>> getEventsByAnfitrion(String idAnfitrion) async {
    Uri url = Uri.https(URL_BASE, EVENTS_BY_ANFITRION, {
      'idAnfitrion': idAnfitrion
    });

    http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    } else {
      List<dynamic> list = json.decode(response.body);
      return list.map((event) => EventRequest.fromJson(event)).toList();
    }
  }

  Future<List<EventRequest>> getAllEvents() async {
    Uri url = Uri.https(URL_BASE, EVENT_ALL);

    http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    } else {
      List<dynamic> list = json.decode(response.body);
      return list.map((event) => EventRequest.fromJson(event)).toList();
    }
  }

  Future<void> saveEvent(EventRequest event) async {
    Uri url = Uri.https(URL_BASE, EVENT_SAVE);

    http.Response response = await http.post(url, body: event.toRawJson());

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    }
  }

  Future<void> inscribe(String idEvent, String idUser) async {
    Uri url = Uri.https(URL_BASE, EVENT_INSCRIBE, {
      'idEvent': idEvent,
      'idUser': idUser,
    });

    http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    }
  }

  Future<void> uninscribe(String idEvent, String idUser) async {
    Uri url = Uri.https(URL_BASE, EVENT_UNINSCRIBE, {
      'idEvent': idEvent,
      'idUser': idUser,
    });

    http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    }
  }
}