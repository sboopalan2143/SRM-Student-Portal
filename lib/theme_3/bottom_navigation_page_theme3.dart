import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/theme_3/change_password_page_theme3.dart';
import 'package:sample/theme_3/home_screen_theme3.dart';
import 'package:sample/theme_3/profile_page_theme3.dart';
import 'package:sample/theme_3/theme_03_selectedtheme_page.dart';
import 'package:sample/theme_3/theme_03_setting_page.dart';
import 'package:sample/theme_3/theme_page_theme3.dart';

class MainScreenPage extends ConsumerStatefulWidget {
  const MainScreenPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends ConsumerState<MainScreenPage> {
  int myCurrentIndex = 0;
  final pages = const [
    HomePageTheme3(),
    Theme03settingPage(),
    Theme03Page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.primaryColorTheme4,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myCurrentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.whiteColor,
        selectedItemColor: AppColors.primaryColorTheme3,
        unselectedItemColor: AppColors.blackColor.withOpacity(0.5),
        iconSize: 25,
        onTap: (index) {
          setState(() {
            myCurrentIndex = index;
            log('Index >>> $myCurrentIndex');
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Explore',
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
