import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sporth/models/models.dart';

class LogrosProvider extends ChangeNotifier {
  List<LogrosAsset> logros = [];

  LogrosProvider() {
    getData();
  }

  getData() async {
    final String response = await rootBundle.loadString('data/logros.json');
    List dataMap = json.decode(response);

    for (var value in dataMap) {
      logros.add(LogrosAsset.fromJson(value));
    }

    notifyListeners();
  }
}
