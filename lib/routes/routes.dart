import 'package:flutter/material.dart';

import 'package:sporth/pages/pages.dart';
import 'package:sporth/utils/utils.dart';
import 'package:sporth/widgets/widgets.dart';

Map<String, WidgetBuilder> getRoutes = {
  INITIAL: (context) => Gateway(),
  HOME: (context) => const PrincipalPlantilla(),
  LOGIN: (context) => const LoginPage(),
  SING_UP: (context) => const SingUpPage(),
  NEW_PASSWORD: (context) => const PasswordPage(),
  USERNAME_PAGE: (context) => const UsernamePage(),
  PERSONAL: (context) => const PersonalPage(),
  GUSTOS: (context) => const GustosPage(),
  ADD_PAGE: (context) => const AddPage(),
  CHATS: (context) => const ChatsPage(),
  CHAT_PERSONAL: (context) => PersonalChatPage(),
  OTHER_USER: (context) => const OtherUserPage(),
  SETTINGS: (context) => const SettingsPage(),
  DETAILS: (context) => const DetailsPage(),
  PERMISOS: (context) => const PermisosPage(),
  TUTORIAL: (context) => const TutorialPage(),
  MAP: (context) => const MapPage(),
};
