import 'package:flutter/material.dart';
import 'package:sporth/pages/chats_page.dart';
import 'package:sporth/pages/other_user_page.dart';
import 'package:sporth/pages/pages.dart';
import 'package:sporth/pages/personal_chat_page.dart';
import 'package:sporth/pages/settings_page.dart';
import 'package:sporth/widgets/widgets.dart';

Map<String, WidgetBuilder> getRoutes = {
  '/': (context) => Gateway(),
  'home': (context) => const PrincipalPlantilla(),
  'login': (context) => const LoginPage(),
  'sing-up': (context) => const SingUpPage(),
  'new-password': (context) => const PasswordPage(),
  'personal': (context) => const PersonalPage(),
  'gustos': (context) => const GustosPage(),
  'add-page': (context) => const AddPage(),
  'chats': (context) => ChatsPage(),
  'chat-personal': (context) => const PersonalChatPage(),
  'other-user': (context) => OtherUserPage(),
  'settings': (context) => const SettingsPage(),
};
