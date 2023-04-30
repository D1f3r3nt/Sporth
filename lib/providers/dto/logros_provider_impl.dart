import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';

class LogrosProviderImpl {
  DatabaseUser _databaseUser = DatabaseUser();
  DatabaseEvento _databaseEvento = DatabaseEvento();

  Future<void> getChatLogro(UserDto user) async {
    if (!user.logros.contains(1)) {
      await _databaseUser.updateLogro(user, 1);
    }
  }

  Future<void> getEventLogro(UserDto user) async {
    List<EventoApi> list =
        await _databaseEvento.getEventsByAnfitrion(user.idUser);

    if (list.length == 1) {
      await _databaseUser.updateLogro(user, 2);
    } else if (list.length == 11) {
      await _databaseUser.updateLogro(user, 3);
    } else if (list.length == 51) {
      await _databaseUser.updateLogro(user, 5);
    }
  }

// Friend Logros do it in databasuser
}
