import 'package:flutter/material.dart';
import 'package:sporth/pages/login_page.dart';
import 'package:sporth/pages/password_page.dart';
import 'package:sporth/pages/personal_page.dart';
import 'package:sporth/pages/sing_up_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: PersonalPage(),
    );
  }
}
