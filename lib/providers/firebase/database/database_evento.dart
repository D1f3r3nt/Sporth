import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';

class DatabaseEvento {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String COLLECTION_NAME = "eventos";

  Future<void> saveEvento(EventoApi evento) async {
    await _db.collection(COLLECTION_NAME).doc().set(evento.toJson());
  }

  Future<List<EventoDto>> getAllEventos() async {
    final CollectionReference events = _db.collection(COLLECTION_NAME);
    final databaseUser = DatabaseUser();

    QuerySnapshot resultEvents = await events.get();
    final deportes = await DeportesProvider().getDataCurrent();

    final eventosApi = resultEvents.docs.map((event) => EventoApi.fromJson(event.data() as Map<String, dynamic>)).toList();

    final List<EventoDto> listResponse = [];

    for (var evento in eventosApi) {
      listResponse.add(EventoDto(
        name: evento.name,
        hora: evento.hora,
        dia: evento.dia,
        ubicacion: evento.ubicacion,
        precio: evento.precio,
        maximo: evento.maximo,
        deporte: deportes.where((e) => e.id == evento.deporte).toList().first,
        imagen: evento.imagen,
        descripcion: evento.descripcion,
        anfitrion: await databaseUser.getUser(evento.anfitrion),
        participantes: await getParticipantes(evento.participantes),
      ));
    }

    return listResponse;
  }

  Future<List<UserDto>> getParticipantes(List<String> participantes) async {
    final databaseUser = DatabaseUser();
    final List<UserDto> listResponse = [];

    participantes.forEach((element) async {
      listResponse.add(await databaseUser.getUser(element));
    });

    return listResponse;
  }
}
