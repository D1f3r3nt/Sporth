import 'package:flutter/material.dart';
import 'package:sporth/pages/pages.dart';

Map<String, WidgetBuilder> getRoutes = {
  //'/': (context) => Gateway(),
  'home': (context) => const PrincipalPlantilla(),
  'add-page': (context) => const AddPage(),
};
