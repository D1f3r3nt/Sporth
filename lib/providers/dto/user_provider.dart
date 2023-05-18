import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';

class UserProvider extends ChangeNotifier {
  UserRequest? _currentUser;

  UserRequest? get currentUser => _currentUser;

  set currentUser(UserRequest? user) {
    _currentUser = user;
    notifyListeners();
  }
}
