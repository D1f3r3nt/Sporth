import 'package:sporth/models/models.dart';
import 'package:sporth/repository/event_repository.dart';
import 'package:sporth/repository/user_repository.dart';

class LogrosService {
  UserRepository _userService = UserRepository();
  EventRepository _eventService = EventRepository();

  Future<void> getChatLogro(UserRequest user) async {
    if (!user.logros.contains(1) && !user.logros.contains(1)) {
      await _userService.updateLogro(user, 1);
    }
  }

  Future<void> getEventLogro(UserRequest user) async {
    List<EventRequest> list =
        await _eventService.getEventsByAnfitrion(user.idUser);

    if (list.length == 1 && !user.logros.contains(2)) {
      await _userService.updateLogro(user, 2);
    } else if (list.length == 11 && !user.logros.contains(3)) {
      await _userService.updateLogro(user, 3);
    } else if (list.length == 51 && !user.logros.contains(5)) {
      await _userService.updateLogro(user, 5);
    }
  }

// Friend Logros do it in databasuser
}
