import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';

class DatabaseEvento {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String COLLECTION_NAME = "eventos";
  final DatabaseUser databaseUser = DatabaseUser();

  // =============
  // GET
  // =============
  Future<List<EventoDto>> getFilterEventos(SearchDto searchDto) async {
    List<EventoDto> listResponse = await getAllEventos();

    listResponse = listResponse.where((element) {
      if (element.maximo > searchDto.maxPersonas) return false;
      if (element.precio > searchDto.precio) return false;

      if (searchDto.deporte != null) {
        if (searchDto.deporte!.isNotEmpty) {
          if (!searchDto.deporte!.contains(element.deporte.id)) return false;
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

  // =====================================================================================
  // =====================================================================================
  // =====================================================================================
  // =====================================================================================
  // API CALLS
  // =====================================================================================
  // =====================================================================================
  // =====================================================================================
  // =====================================================================================

  // =============
  // GET
  // =============

  Future<EventoApi> getEvento(String idEvento) async {
    log('GET -- EVENTO');

    return await _db.collection(COLLECTION_NAME).doc(idEvento).get().then(
        (value) => EventoApi.fromJson(value.data() as Map<String, dynamic>));
  }

  Future<List<EventoDto>> getAllEventos() async {
    log('GET -- ALL EVENTOS');

    final CollectionReference events = _db.collection(COLLECTION_NAME);
    // .where('anfitrion', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
    QuerySnapshot resultEvents = await events.get();

    final listIds = [];
    final eventosApi = resultEvents.docs.map((event) {
      listIds.add(event.id);
      return EventoApi.fromJson(event.data() as Map<String, dynamic>);
    }).toList();

    final List<EventoDto> listResponse = [];
    for (int i = 0; i < eventosApi.length; i++) {
      listResponse.add(await EventoMapper.INSTANCE
          .eventoApiToEventoDto(listIds[i], eventosApi[i]));
    }
    return listResponse;
  }

  // =============
  // POST
  // =============
  Future<void> saveEvento(EventoApi evento) async {
    log('POST -- SAVE EVENTO');
    await _db.collection(COLLECTION_NAME).doc().set(evento.toJson());
  }

  Future<void> inscribe(String idEvento, String idUser) async {
    log('POST -- INSCRIBE');
    EventoApi eventoApi = await getEvento(idEvento);
    eventoApi.participantes.add(idUser);

    await _db
        .collection(COLLECTION_NAME)
        .doc(idEvento)
        .update(eventoApi.toJson());
  }
}
