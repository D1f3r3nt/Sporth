import 'package:http/http.dart' as http;
import 'package:sporth/models/models.dart';

import '../../utils/utils.dart';

class UserService {
  Future<UserRequest> getUser(String idUser) async {
    Uri _url = Uri.https(URL_BASE, USER_ONE, {
      'idUser': idUser
    });

    http.Response response = await http.get(_url);
    
    if (response.statusCode != 200) {
      throw Exception('Error with call');
    } else {
      return UserRequest.fromRawJson(response.body);
    }
  }

  Future<bool> existsUser(String idUser) async {
    Uri _url = Uri.https(URL_BASE, USER_EXISTS, {
      'idUser': idUser
    });

    http.Response response = await http.get(_url);

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    } else {
      return response.body as bool;
    }
  }

  Future<bool> existsUsername(String username) async {
    Uri _url = Uri.https(URL_BASE, USERNAME_EXISTS, {
      'username': username
    });

    http.Response response = await http.get(_url);

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    } else {
      return response.body as bool;
    }
  }

  Future<void> saveUser(UserRequest user) async {
    Uri _url = Uri.https(URL_BASE, USER_SAVE);

    http.Response response = await http.post(_url, body: user.toRawJson());

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    }
  }

  Future<void> updateUser(UserRequest user) async {
    Uri _url = Uri.https(URL_BASE, USER_UPDATE);

    http.Response response = await http.post(_url, body: user.toRawJson());

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    }
  }

  Future<void> updateSeguidor(UserRequest user, String idUser) async {
    Uri _url = Uri.https(URL_BASE, SEGUIDOR_UPGRADE, {
      'idFollower': idUser,
    });

    http.Response response = await http.post(_url, body: user.toRawJson());

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    }
  }

  Future<void> updateDejar(UserRequest user, String idUser) async {
    Uri _url = Uri.https(URL_BASE, SEGUIDOR_DEGRADE, {
      'idFollower': idUser,
    });

    http.Response response = await http.post(_url, body: user.toRawJson());

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    }
  }

  Future<void> updateLogro(UserRequest user, int idLogro) async {
    Uri _url = Uri.https(URL_BASE, USER_LOGRO, {
      'idLogro': idLogro,
    });

    http.Response response = await http.post(_url, body: user.toRawJson());

    if (response.statusCode != 200) {
      throw Exception('Error with call');
    }
  }
}