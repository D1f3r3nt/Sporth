import 'package:flutter/material.dart';
import 'package:sporth/pages/chats_page.dart';
import 'package:sporth/pages/pages.dart';

Map<String, WidgetBuilder> getRoutes = {
  //'/': (context) => Gateway(),
  'home': (context) => const PrincipalPlantilla(),
  'add-page': (context) => const AddPage(),
  'chats': (context) => const ChatsPage(),
};
