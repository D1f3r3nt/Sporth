import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sporth/models/dto/geografico_dto.dart';
import 'package:sporth/utils/snackbar.dart';

class PositionProvider {
  Future<GeograficoDto?> getPosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Snackbar.errorSnackbar(context, 'Ubicacion desactivada');
      return null;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Snackbar.errorSnackbar(context, 'La app necesita permisos de ubicacion');
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Snackbar.errorSnackbar(context, 'La app necesita permisos de ubicacion');
      return null;
    }

    Position position = await Geolocator.getCurrentPosition();

    return GeograficoDto(lat: position.latitude, lng: position.longitude);
  }
}
