import 'package:sporth/models/api/mensaje_api.dart';
import 'package:sporth/models/dto/mensaje_dto.dart';
import 'package:sporth/providers/providers.dart';

class MensajeMapper {
  static final MensajeMapper INSTANCE = MensajeMapper._();

  final DatabaseUser databaseUser = DatabaseUser();

  MensajeMapper._();

  MensajeApi mensajeDtoToMensajeApi(MensajeDto mensajeDto) {
    return MensajeApi(
      editor: mensajeDto.editor.idUser,
      mensaje: mensajeDto.mensaje,
      creacion: mensajeDto.creacion,
    );
  }

  Future<MensajeDto> mensajeApiToMensajeDto(MensajeApi mensajeApi) async {
    return MensajeDto(
      editor: await databaseUser.getUser(mensajeApi.editor),
      mensaje: mensajeApi.mensaje,
      creacion: mensajeApi.creacion,
    );
  }

  List<MensajeApi> listMensajeDtoToListMensajeApi(List<MensajeDto> list) {
    return list.map((e) => mensajeDtoToMensajeApi(e)).toList();
  }

  Future<List<MensajeDto>> listMensajeApiToListMensajeDto(
      List<MensajeApi> list) async {
    List<MensajeDto> result = [];
    for (MensajeApi mensajeApi in list) {
      result.add(await mensajeApiToMensajeDto(mensajeApi));
    }

    return result;
  }
}
