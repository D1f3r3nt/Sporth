import 'package:flutter/material.dart';

import 'package:sporth/models/models.dart';
import 'package:sporth/pages/pages.dart';
import 'package:sporth/providers/providers.dart';
import 'package:sporth/utils/utils.dart';

class PrincipalPlantilla extends StatelessWidget {
  const PrincipalPlantilla({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavProvider bottomNavProvider = Provider.of<BottomNavProvider>(context);
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final UserDto user = userProvider.currentUser!;

    chats() => Navigator.pushReplacementNamed(context, 'chats');

    settings() => Navigator.pushReplacementNamed(context, 'settings');

    tapNavigation(int value) {
      if (value == 2) {
        Navigator.pushReplacementNamed(context, 'add-page');
        value = 0;
      }
      bottomNavProvider.index = value;
    }

    gatewayPages(BuildContext context, int index) {
      switch (index) {
        case 0:
          return HomePage();

        case 1:
          return const SearchPage();

        case 3:
          return const CalendarPage();

        case 4:
          return const UserPage();
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: (bottomNavProvider.index == 0)
          ? AppBar(
              centerTitle: true,
              title: const Text(
                'Sporth',
                style: TextUtils.kanitItalic_24_black,
              ),
              backgroundColor: Colors.white,
              elevation: 0.5,
              actions: [
                IconButton(
                  onPressed: chats,
                  icon: const Icon(
                    Icons.message,
                    color: ColorsUtils.black,
                  ),
                )
              ],
            )
          : (bottomNavProvider.index == 4)
              ? AppBar(
                  centerTitle: true,
                  title: Text(
                    user.username,
                    style: TextUtils.kanit_18_grey,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  actions: [
                    IconButton(
                      onPressed: settings,
                      icon: const Icon(
                        Icons.settings,
                        color: ColorsUtils.grey,
                      ),
                    )
                  ],
                )
              : null,
      body: gatewayPages(context, bottomNavProvider.index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavProvider.index,
        showSelectedLabels: false,
        backgroundColor: ColorsUtils.creme,
        elevation: 10.0,
        iconSize: 35,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        unselectedIconTheme: const IconThemeData(
          color: ColorsUtils.grey,
        ),
        selectedIconTheme: const IconThemeData(
          color: ColorsUtils.black,
        ),
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        type: BottomNavigationBarType.fixed,
        onTap: (value) => tapNavigation(value),
      ),
    );
  }
}
