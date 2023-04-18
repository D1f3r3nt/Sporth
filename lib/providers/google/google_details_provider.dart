import 'dart:convert';
import 'dart:developer';

import 'package:sporth/models/dto/geografico_dto.dart';
import 'package:sporth/models/models.dart';
import 'package:http/http.dart' as http;

class GoogleDetailsProvider {
  static const String URL_BASE = "maps.googleapis.com";
  static const String ENPOINT_AUTOCOMPLETE = "maps/api/place/details/json";
  static const String API_KEY = "AIzaSyCCUp-ccTjSHctnF102V-MZnwL8YCgBAcU";

  Future<GeograficoDto> getData(String placeId) async {
    log('GET -- GOOGLE DETAILS');
    var url = Uri.https(URL_BASE, ENPOINT_AUTOCOMPLETE, {
      'key': API_KEY,
      'place_id': placeId,
    });
    var response = await http.get(url);

    GoogleDetails details = GoogleDetails.fromJson(jsonDecode(response.body));

    return GeograficoDto(lat: details.result.geometry.location.lat, lng: details.result.geometry.location.lng);
  }
}
