import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static bool _isFirstTime = true;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isFirstTime {
    return _prefs.getBool('first-time') ?? _isFirstTime;
  }

  static set isFirstTime(bool type) {
    _isFirstTime = type;
    _prefs.setBool('first-time', type);
  }
}
