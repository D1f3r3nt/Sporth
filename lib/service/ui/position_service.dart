import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/utils/utils.dart';

class PositionService {
  Future<GeograficoDto?> getPosition(BuildContext context) async {
    bool check = await checkAll(context);
    
    if (!check) return null;

    Position position = await Geolocator.getCurrentPosition();

    return GeograficoDto(lat: position.latitude, lng: position.longitude);
  }
  
  Future<bool> checkAll(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Snackbar.errorSnackbar(context, 'Ubicacion desactivada');
      return false;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Snackbar.errorSnackbar(context, 'La app necesita permisos de ubicacion');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Snackbar.errorSnackbar(context, 'La app necesita permisos de ubicacion');
      return false;
    }
    
    return true;
  }
  
  Future<bool> isEnabled() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
        return false;
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }
}
