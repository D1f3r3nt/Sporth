import 'package:sporth/models/models.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/services/functions/event_service.dart';

class LogrosProviderImpl {
  DatabaseUser _databaseUser = DatabaseUser();
  EventService _eventService = EventService();

  Future<void> getChatLogro(UserRequest user) async {
    if (!user.logros.contains(1)) {
      await _databaseUser.updateLogro(user, 1);
    }
  }

  Future<void> getEventLogro(UserRequest user) async {
    List<EventRequest> list =
        await _eventService.getEventsByAnfitrion(user.idUser);

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
