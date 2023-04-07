import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sporth/models/models.dart';
import 'package:sporth/providers/firebase/database/database_evento.dart';

class EventosProvider extends ChangeNotifier {
  final databaseEvento = DatabaseEvento();
  List<EventoDto> allEventos = [];

  Future<void> refresh() async {
    allEventos = [];
    notifyListeners();
  }

  void getAllEventosOneTime() async {
    log('GET_ALL_EVENTOS');
    final oldList = allEventos;
    allEventos = await databaseEvento.getAllEventos();
    if (oldList.isEmpty) {
      notifyListeners();
    }
    log('CORRECT - GET_ALL_EVENTOS');
  }
}
