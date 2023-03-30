import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporth/pages/home_page.dart';
import 'package:sporth/pages/login_page.dart';
import 'package:sporth/providers/dto/bottom_nav_provider.dart';
import 'package:sporth/utils/color_utils.dart';
import 'package:sporth/utils/effect_utils.dart';
import 'package:sporth/utils/text_utils.dart';

class PrincipalPlantilla extends StatelessWidget {
  const PrincipalPlantilla({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      backgroundColor: ColorsUtils.white,
      appBar: (bottomNavProvider.index == 0)
          ? AppBar(
              centerTitle: true,
              title: const Text(
                'Sporth',
                style: TextUtils.kanitItalic_24_black,
              ),
              backgroundColor: ColorsUtils.white,
              elevation: 0.5,
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.message,
                      color: ColorsUtils.black,
                    ))
              ],
            )
          : null,
      body: gatewayPages(bottomNavProvider.index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavProvider.index,
        showSelectedLabels: false,
        backgroundColor: ColorsUtils.white,
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
          color: ColorsUtils.creme,
        ),
        selectedIconTheme: const IconThemeData(
          color: ColorsUtils.black,
        ),
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        type: BottomNavigationBarType.fixed,
        onTap: (value) => bottomNavProvider.index = value,
      ),
    );
  }

  gatewayPages(int index) {
    switch (index) {
      case 0:
        {
          return HomePage();
        }
      default:
        {
          return LoginPage();
        }
    }
  }
}
