import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/utils/utils.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  
  @override
  Widget build(BuildContext context) {
    final GeograficoDto geo = ModalRoute.of(context)!.settings.arguments as GeograficoDto;

    Marker marker = Marker(
      markerId: const MarkerId('Evento'),
      position: LatLng(geo.lat, geo.lng),
    );

    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(geo.lat, geo.lng),
      zoom: 15,
    );
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsUtils.grey,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: {marker},
        initialCameraPosition: cameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}