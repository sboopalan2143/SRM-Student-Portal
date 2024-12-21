import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/theme-02/theme02_homepage.dart';
import 'package:sample/theme-02/theme_02_selectedtheme_page.dart';
import 'package:sample/theme-02/theme_02setting_page.dart';
import 'package:sample/theme-06/dhasboard_06_page.dart';
import 'package:sample/theme-06/theme06_homepage.dart';
import 'package:sample/theme-06/theme_06_selectedtheme_page.dart';
import 'package:sample/theme-06/theme_06setting_page.dart';

class Theme06MainScreenPage extends ConsumerStatefulWidget {
  const Theme06MainScreenPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme06MainScreenPageState();
}

class _Theme06MainScreenPageState extends ConsumerState<Theme06MainScreenPage> {
  int myCurrentIndex = 0;
  final pages = const [
    Theme06dhasboardPage(),
    Theme06Homepage(),
    Theme06Page(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myCurrentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.whiteColor,
        selectedItemColor: AppColors.theme06primaryColor,
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
            icon: Icon(Icons.dashboard_sharp),
            label: 'Explore',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_2_outlined),
          //   label: 'Profile',
          // ),
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
