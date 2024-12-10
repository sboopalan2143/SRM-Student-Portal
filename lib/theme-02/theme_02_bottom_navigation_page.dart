import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/home/drawer_pages/theme/screens/theme.dart';
import 'package:sample/theme-02/drawer_page/theme02_profile_screen.dart';
import 'package:sample/theme-02/theme02_homepage.dart';
import 'package:sample/theme-02/theme_02_selectedtheme_page.dart';
import 'package:sample/theme-02/theme_02setting_page.dart';

class Theme02MainScreenPage extends ConsumerStatefulWidget {
  const Theme02MainScreenPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme02MainScreenPageState();
}

class _Theme02MainScreenPageState extends ConsumerState<Theme02MainScreenPage> {
  int myCurrentIndex = 0;
  final pages = const [
    Theme02Homepage(),
    Theme02settingPage(),
    Theme02ProfilePage(),
    Theme02Page(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myCurrentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.whiteColor,
        selectedItemColor: AppColors.primaryColor2,
        unselectedItemColor: AppColors.lightAshColor,
        iconSize: 25,
        onTap: (index) {
          setState(() {
            myCurrentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phonelink_setup_outlined),
            label: 'Theme',
          ),
        ],
      ),
      body: pages[myCurrentIndex],
    );
  }
}
