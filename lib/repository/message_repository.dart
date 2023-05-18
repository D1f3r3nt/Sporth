import 'package:sporth/models/models.dart';
import 'package:sporth/utils/strings.dart';

import 'package:http/http.dart' as http;

class MessageRepository {

  Future<void> sendMessage(String idChat, MessageRequest message) async {
    Uri url = Uri.https(URL_BASE, MESSAGE_SAVE, {
      'idChat': idChat,
    });

    http.Response response = await http.post(url, body: message.toRawJson());

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    }
  }
}