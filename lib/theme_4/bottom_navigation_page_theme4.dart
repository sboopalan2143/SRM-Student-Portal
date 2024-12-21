import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/theme_4/dhasboard_04_page.dart';
import 'package:sample/theme_4/home_screen_theme4.dart';
import 'package:sample/theme_4/theme_04_selectedtheme_page.dart';

class MainScreenPage4 extends ConsumerStatefulWidget {
  const MainScreenPage4({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainScreenPage4State();
}

class _MainScreenPage4State extends ConsumerState<MainScreenPage4> {
  int myCurrentIndex = 0;
  final pages = const [
    Theme04dhasboardPage(),
    HomePageTheme4(),
    ThemePageTheme4(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myCurrentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.whiteColor,
        selectedItemColor: AppColors.theme4color2,
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
