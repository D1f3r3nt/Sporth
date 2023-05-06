import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';

class EventoMapper {
  static final EventoMapper INSTANCE = EventoMapper._();

  final DatabaseUser databaseUser = DatabaseUser();
  final DeportesProvider deportesProvider = DeportesProvider();

  EventoMapper._();

  EventoApi enventoDtoToEventoApi(EventoDto eventoDto) {
    return EventoApi(
      name: eventoDto.name,
      hora: eventoDto.hora,
      dia: eventoDto.dia,
      ubicacion: eventoDto.ubicacion,
      precio: eventoDto.precio,
      maximo: eventoDto.maximo,
      deporte: eventoDto.deporte.id,
      imagen: eventoDto.imagen,
      descripcion: eventoDto.descripcion,
      anfitrion: eventoDto.anfitrion.idUser,
      participantes: eventoDto.participantes.map((e) => e.idUser).toList(),
      geo: eventoDto.geo,
    );
  }

  Future<EventoDto> eventoApiToEventoDto(String id, EventoApi eventoApi) async {
    return EventoDto(
      id: id,
      name: eventoApi.name,
      hora: eventoApi.hora,
      dia: eventoApi.dia,
      ubicacion: eventoApi.ubicacion,
      precio: eventoApi.precio,
      maximo: eventoApi.maximo,
      deporte: await deportesProvider.getDeporteById(eventoApi.deporte),
      imagen: eventoApi.imagen,
      descripcion: eventoApi.descripcion,
      anfitrion: await databaseUser.getUser(eventoApi.anfitrion),
      geo: eventoApi.geo,
      participantes: await _getParticipantes(eventoApi.participantes),
    );
  }

  Future<List<UserDto>> _getParticipantes(List<String> participantes) async {
    final List<UserDto> listResponse = [];

    participantes.forEach((element) async {
      listResponse.add(await databaseUser.getUser(element));
    });

    return listResponse;
  }
}
