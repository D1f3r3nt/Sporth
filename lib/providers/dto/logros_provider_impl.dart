import 'package:sporth/models/models.dart';
import 'package:sporth/services/functions/event_service.dart';
import 'package:sporth/services/functions/user_service.dart';

class LogrosProviderImpl {
  UserService _userService = UserService();
  EventService _eventService = EventService();

  Future<void> getChatLogro(UserRequest user) async {
    if (!user.logros.contains(1)) {
      await _userService.updateLogro(user, 1);
    }
  }

  Future<void> getEventLogro(UserRequest user) async {
    List<EventRequest> list =
        await _eventService.getEventsByAnfitrion(user.idUser);

    if (list.length == 1) {
      await _userService.updateLogro(user, 2);
    } else if (list.length == 11) {
      await _userService.updateLogro(user, 3);
    } else if (list.length == 51) {
      await _userService.updateLogro(user, 5);
    }
  }

// Friend Logros do it in databasuser
}
