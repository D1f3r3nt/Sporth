import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';

class UserProvider extends ChangeNotifier {
  UserDto? _currentUser;

  UserDto? get currentUser => _currentUser;

  set currentUser(UserDto? user) {
    _currentUser = user;
    notifyListeners();
  }
}
