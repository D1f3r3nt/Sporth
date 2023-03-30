import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporth/pages/gustos_page.dart';
import 'package:sporth/pages/login_page.dart';
import 'package:sporth/pages/password_page.dart';
import 'package:sporth/pages/personal_page.dart';
import 'package:sporth/pages/principal_plantilla.dart';
import 'package:sporth/pages/sing_up_page.dart';
import 'package:sporth/providers/dto/bottom_nav_provider.dart';
import 'package:sporth/providers/local/deportes_provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeportesProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: PrincipalPlantilla(),
    );
  }
}
