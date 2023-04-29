import 'package:sporth/models/models.dart';

class ChatDto {
  ChatDto({
    this.idChat,
    required this.anfitriones,
    this.idEvent,
  });

  final String? idChat;
  final List<UserDto> anfitriones;
  final String? idEvent;

  ChatDto copyWith({
    String? idChat,
    List<UserDto>? anfitriones,
    String? idEvent,
  }) =>
      ChatDto(
        idChat: idChat ?? this.idChat,
        anfitriones: anfitriones ?? this.anfitriones,
        idEvent: idEvent ?? this.idEvent,
      );

  UserDto getOtherAnfitrion(String idUser) {
    return anfitriones.where((element) => element.idUser != idUser).toList().first;
  }
}
