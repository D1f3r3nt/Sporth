import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';

class DatabaseEvento {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String COLLECTION_NAME = "eventos";
  final databaseUser = DatabaseUser();

  Future<void> saveEvento(EventoApi evento) async {
    await _db.collection(COLLECTION_NAME).doc().set(evento.toJson());
  }

  Future<List<EventoDto>> getAllEventos() async {
    final CollectionReference events = _db.collection(COLLECTION_NAME);

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

    return listResponse;
  }

  Future<EventoDto> getEventoDto(String idEvento) async {
    final deportes = await DeportesProvider().getDataCurrent();
    String id = '';
    EventoApi eventoApi = await _db.collection(COLLECTION_NAME).doc(idEvento).get().then((value) {
      id = value.id;
      return EventoApi.fromJson(value as Map<String, dynamic>);
    });

    return EventoDto(
      id: id,
      name: eventoApi.name,
      hora: eventoApi.hora,
      dia: eventoApi.dia,
      ubicacion: eventoApi.ubicacion,
      precio: eventoApi.precio,
      maximo: eventoApi.maximo,
      deporte: deportes.where((e) => e.id == eventoApi.deporte).toList().first,
      imagen: eventoApi.imagen,
      descripcion: eventoApi.descripcion,
      anfitrion: await databaseUser.getUser(eventoApi.anfitrion),
      participantes: await _getParticipantes(eventoApi.participantes),
    );
  }

  Future<EventoApi> getEventoApi(String idEvento) async {
    return await _db.collection(COLLECTION_NAME).doc(idEvento).get().then((value) => EventoApi.fromJson(value.data() as Map<String, dynamic>));
  }

  Future<void> inscribe(String idEvento, String idUser) async {
    EventoApi eventoApi = await getEventoApi(idEvento);
    eventoApi.participantes.add(idUser);

    await _db.collection(COLLECTION_NAME).doc(idEvento).update(eventoApi.toJson());
  }

  Future<List<UserDto>> _getParticipantes(List<String> participantes) async {
    final List<UserDto> listResponse = [];

    participantes.forEach((element) async {
      listResponse.add(await databaseUser.getUser(element));
    });

    return listResponse;
  }
}
