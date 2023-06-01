import 'package:http/http.dart' as http;
import 'package:sporth/models/models.dart';

import '../utils/utils.dart';

class UserRepository {

  Future<void> getFriendLogro(UserRequest user) async {
    if (!user.logros.contains(4)) {
      await updateLogro(user, 4);
    }
  }
  
  Future<UserRequest> getUser(String idUser) async {
    Uri url = Uri.https(URL_BASE, USER_ONE, {
      'idUser': idUser
    });

    http.Response response = await http.get(url);
    
    if (response.statusCode != 200) {
      throw Exception('Error with call');
    } else {
      return UserRequest.fromRawJson(response.body);
    }
  }

  Future<bool> existsUser(String idUser) async {
    Uri url = Uri.https(URL_BASE, USER_EXISTS, {
      'idUser': idUser
    });

    http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    } else {
      return response.body == 'true';
    }
  }

  Future<bool> existsUsername(String username) async {
    Uri url = Uri.https(URL_BASE, USERNAME_EXISTS, {
      'username': username
    });

    http.Response response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    } else {
      return response.body == 'true';
    }
  }

  Future<void> saveUser(UserRequest user) async {
    Uri url = Uri.https(URL_BASE, USER_SAVE);

    http.Response response = await http.post(url, body: user.toRawJson());

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    }
  }

  Future<void> updateUser(UserRequest user) async {
    Uri url = Uri.https(URL_BASE, USER_UPDATE);

    http.Response response = await http.post(url, body: user.toRawJson());

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    }
  }

  Future<void> updateSeguidor(UserRequest user, String idUser) async {
    Uri url = Uri.https(URL_BASE, SEGUIDOR_UPGRADE, {
      'idFollower': idUser,
    });

    http.Response response = await http.post(url, body: user.toRawJson());

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    }
  }

  Future<void> updateDejar(UserRequest user, String idUser) async {
    Uri url = Uri.https(URL_BASE, SEGUIDOR_DEGRADE, {
      'idFollower': idUser,
    });

    http.Response response = await http.post(url, body: user.toRawJson());

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    }
  }

  Future<void> updateLogro(UserRequest user, int idLogro) async {
    Uri url = Uri.https(URL_BASE, USER_LOGRO, {
      'idLogro': idLogro.toString(),
    });

    http.Response response = await http.post(url, body: user.toRawJson());

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    }
  }
}