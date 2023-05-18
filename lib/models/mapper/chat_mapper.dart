import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/services/functions/event_service.dart';

class ChatMapper {
  static final ChatMapper INSTANCE = ChatMapper._();

  final DatabaseUser _databaseUser = DatabaseUser();
  final EventService _eventService = EventService();

  ChatMapper._();

  ChatApi chatDtoToChatApi(ChatDto chatDto) {
    return ChatApi(
      anfitriones: chatDto.anfitriones.map((e) => e.idUser).toList(),
      idChat: chatDto.idChat,
      idEvent: chatDto.event?.id,
    );
  }

  Future<ChatDto> chatApiToChatDto(ChatApi chatApi) async {
    return ChatDto(
      anfitriones: await _convertRefToDto(chatApi.anfitriones),
      idChat: chatApi.idChat,
      event: await _convertRefToEvent(chatApi.idEvent),
    );
  }

  List<ChatApi> listChatDtoToListChatApi(List<ChatDto> list) {
    return list.map((e) => chatDtoToChatApi(e)).toList();
  }

  Future<List<ChatDto>> listChatApiToListChatDto(List<ChatApi> list) async {
    List<ChatDto> result = [];
    for (ChatApi chatApi in list) {
      result.add(await chatApiToChatDto(chatApi));
    }

    return result;
  }

  Future<EventoDto?> _convertRefToEvent(String? idEvent) async {
    if (idEvent == null) return null;
    /*EventoApi eventoApi = await _eventService.getEvent(idEvent!);
    return EventoMapper.INSTANCE.eventoApiToEventoDto(idEvent, eventoApi);*/
  }

  Future<List<UserDto>> _convertRefToDto(List<String> ref) async {
    List<UserDto> result = [];

    for (var reference in ref) {
      result.add(await _databaseUser.getUser(reference));
    }

    return result;
  }
}
