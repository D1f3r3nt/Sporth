import 'package:sporth/models/models.dart';

class ChatDto {
  ChatDto({
    this.idChat,
    required this.anfitriones,
    this.event,
  });

  final String? idChat;
  final List<UserDto> anfitriones;
  final EventoDto? event;

  ChatDto copyWith({
    String? idChat,
    List<UserDto>? anfitriones,
    EventoDto? event,
  }) =>
      ChatDto(
        idChat: idChat ?? this.idChat,
        anfitriones: anfitriones ?? this.anfitriones,
        event: event ?? this.event,
      );

  UserDto getOtherAnfitrion(String idUser) {
    return anfitriones
        .where((element) => element.idUser != idUser)
        .toList()
        .first;
  }
}
