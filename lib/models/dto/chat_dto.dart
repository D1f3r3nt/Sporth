import 'package:sporth/models/models.dart';

class ChatDto {
  ChatDto({
    this.idChat,
    required this.anfitriones,
    this.nombreEvento,
    this.fotoEvento,
    this.datosEvento,
    required this.mensajes,
  });

  final String? idChat;
  final List<UserDto> anfitriones;
  final String? nombreEvento;
  final String? fotoEvento;
  final String? datosEvento;
  final List<MensajeDto> mensajes;

  ChatDto copyWith({
    String? idChat,
    List<UserDto>? anfitriones,
    String? nombreEvento,
    String? fotoEvento,
    String? datosEvento,
    List<MensajeDto>? mensajes,
  }) =>
      ChatDto(
        idChat: idChat ?? this.idChat,
        anfitriones: anfitriones ?? this.anfitriones,
        nombreEvento: nombreEvento ?? this.nombreEvento,
        fotoEvento: fotoEvento ?? this.fotoEvento,
        datosEvento: datosEvento ?? this.datosEvento,
        mensajes: mensajes ?? this.mensajes,
      );

  UserDto getOtherAnfitrion(String idUser) {
    return anfitriones.where((element) => element.idUser != idUser).toList().first;
  }
}
