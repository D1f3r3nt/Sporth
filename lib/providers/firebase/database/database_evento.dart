import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporth/models/dto/search_dto.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';

class DatabaseEvento {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String COLLECTION_NAME = "eventos";
  final databaseUser = DatabaseUser();
  List<EventoDto> _allEvents = [];

  // =============
  // GET
  // =============
  Future<List<EventoDto>> get allEvents async {
    if (_allEvents.isEmpty) {
      await _getAllEventos();
    }
    return _allEvents;
  }

  Future<List<EventoDto>> get importantAllEvents async {
    await _getAllEventos();
    return _allEvents;
  }

  Future<List<EventoDto>> getFilterEventos(SearchDto searchDto) async {
    List<EventoDto> listResponse = await allEvents;

    listResponse = listResponse.where((element) {
      if (element.maximo > searchDto.maxPersonas) return false;
      if (element.precio > searchDto.precio) return false;

      if (searchDto.deporte != null) {
        if (searchDto.deporte!.isNotEmpty) {
          if (!searchDto.deporte!.contains(element.deporte.id)) return false;
        }
      }

      if (searchDto.nombre != null) {
        if (!element.name.toLowerCase().contains(searchDto.nombre!.toLowerCase())) return false;
      }

      if (searchDto.dia != null && searchDto.dia!.isNotEmpty) {
        if (searchDto.dia != element.diaFormat) return false;
      }

      if (searchDto.hora != null && searchDto.hora!.isNotEmpty) {
        if (searchDto.hora != element.timeFormat) return false;
      }

      return true;
    }).toList();

    return listResponse;
  }

  Future<List<UserDto>> _getParticipantes(List<String> participantes) async {
    final List<UserDto> listResponse = [];

    participantes.forEach((element) async {
      listResponse.add(await databaseUser.getUser(element));
    });

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
  Future<void> _getAllEventos() async {
    log('GET -- ALL_EVENTOS');
    final CollectionReference events = _db.collection(COLLECTION_NAME);

    // .where('anfitrion', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)

    QuerySnapshot resultEvents = await events.get();
    final deportes = await DeportesProvider().getDataCurrent();
    final listIds = [];

    final eventosApi = resultEvents.docs.map((event) {
      listIds.add(event.id);
      return EventoApi.fromJson(event.data() as Map<String, dynamic>);
    }).toList();

    final List<EventoDto> listResponse = [];

    for (int i = 0; i < eventosApi.length; i++) {
      listResponse.add(EventoDto(
        id: listIds[i],
        name: eventosApi[i].name,
        hora: eventosApi[i].hora,
        dia: eventosApi[i].dia,
        ubicacion: eventosApi[i].ubicacion,
        precio: eventosApi[i].precio,
        maximo: eventosApi[i].maximo,
        deporte: deportes.where((e) => e.id == eventosApi[i].deporte).toList().first,
        imagen: eventosApi[i].imagen,
        descripcion: eventosApi[i].descripcion,
        anfitrion: await databaseUser.getUser(eventosApi[i].anfitrion),
        participantes: await _getParticipantes(eventosApi[i].participantes),
      ));
    }

    _allEvents = listResponse;
  }

  Future<EventoApi> _getEventoApi(String idEvento) async {
    log('GET -- EVENTO_API');

    return await _db.collection(COLLECTION_NAME).doc(idEvento).get().then((value) => EventoApi.fromJson(value.data() as Map<String, dynamic>));
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
    EventoApi eventoApi = await _getEventoApi(idEvento);
    eventoApi.participantes.add(idUser);

    await _db.collection(COLLECTION_NAME).doc(idEvento).update(eventoApi.toJson());
  }
}
