import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';

class ChatMapper {
  static final ChatMapper INSTANCE = ChatMapper._();

  final DatabaseUser _databaseUser = DatabaseUser();

  ChatMapper._();

  ChatApi chatDtoToChatApi(ChatDto chatDto) {
    return ChatApi(
      anfitriones: chatDto.anfitriones.map((e) => e.idUser).toList(),
      idChat: chatDto.idChat,
      idEvent: chatDto.idEvent,
    );
  }

  Future<ChatDto> chatApiToChatDto(ChatApi chatApi) async {
    return ChatDto(
      anfitriones: await _convertRefToDto(chatApi.anfitriones),
      idChat: chatApi.idChat,
      idEvent: chatApi.idEvent,
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

  Future<List<UserDto>> _convertRefToDto(List<String> ref) async {
    List<UserDto> result = [];

    for (var reference in ref) {
      result.add(await _databaseUser.getUser(reference));
    }

    return result;
  }
}
