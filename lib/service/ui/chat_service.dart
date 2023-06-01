import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/service/ui/logros_service.dart';
import 'package:sporth/repository/repository.dart';

class ChatService {
  final ChatRepository _chatService = ChatRepository();
  final MessageRepository _messageService = MessageRepository();
  final LogrosService _logrosProviderImpl = LogrosService();

  Future<List<ChatRequest>> getChats() async {
    return await _chatService.getChats();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMensajes(String idChat) async* {
    yield* FirebaseFirestore.instance
        .collection('chats/$idChat/mensajes')
        .orderBy('creacion', descending: true)
        .snapshots();
  }

  Future<ChatRequest?> getChatByEvent(String idEvent) async {
    return await _chatService.getChatByEvent(idEvent);
  }

  Future<String> anyChatUser(String idUser, String idOtherUser) async {
    return await _chatService.anyChatUser(idUser, idOtherUser);
  }

  Future<String> saveChat(ChatRequest newChat) async {
    return await _chatService.saveChat(newChat);
  }

  Future<void> updateChat(ChatRequest chatApi) async {
    await _chatService.updateChat(chatApi);
  }

  void sendMessage(String idChat, String mensaje, UserRequest user) async {

    MessageRequest messageRequest = MessageRequest(editor: user, creacion: DateTime.now(), mensaje: mensaje);
    
    await _messageService.sendMessage(idChat, messageRequest);
    await _logrosProviderImpl.getChatLogro(user);
  }
}
