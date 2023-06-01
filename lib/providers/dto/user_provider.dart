import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/repository/repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  UserRequest? _currentUser;

  UserRequest? get currentUser => _currentUser;

  set currentUser(UserRequest? user) {
    _currentUser = user;
    notifyListeners();
  }
  
  Future<void> update() async {
    currentUser = await _userRepository.getUser(currentUser!.idUser);
    notifyListeners();
  }
}
