import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:http/http.dart' as http;

class GoogleAutocompleteProvider extends ChangeNotifier {
  List<GooglePlaceAutocomplete> lugares = [];
  static const String URL_BASE = "maps.googleapis.com";
  static const String ENPOINT_AUTOCOMPLETE = "maps/api/place/autocomplete/json";
  static const String API_KEY = "AIzaSyCCUp-ccTjSHctnF102V-MZnwL8YCgBAcU";

  // https://developers.google.com/maps/documentation/places/web-service/supported_types?hl=es-419#table1
  static const String TYPES = "park|bar|university|gym|bowling_alley";

  void cleanData() {
    lugares = [];
    notifyListeners();
  }

  void cleanDataWithoutNotify() {
    lugares = [];
  }

  void getData(String search) async {
    log('GET -- GOOGLE AUTOCOMPLETE');
    var url = Uri.https(URL_BASE, ENPOINT_AUTOCOMPLETE, {
      'key': API_KEY,
      'types': TYPES,
      'input': search,
    });
    var response = await http.get(url);

    GoogleAutocomplete autocomplete = GoogleAutocomplete.fromJson(jsonDecode(response.body));

    lugares = autocomplete.predictions;
    notifyListeners();
  }
}
