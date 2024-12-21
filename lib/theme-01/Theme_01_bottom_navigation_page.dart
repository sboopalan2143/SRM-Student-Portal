import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/theme-01/dhasboard_01_page.dart';
import 'package:sample/theme-01/drawer_page/theme01_profile_screen.dart';
import 'package:sample/theme-01/setting_page.dart';
import 'package:sample/theme-01/theme01_homepage.dart';
import 'package:sample/theme-01/theme_01_selectedtheme_page.dart';

class Theme01MainScreenPage extends ConsumerStatefulWidget {
  const Theme01MainScreenPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme01MainScreenPageState();
}

class _Theme01MainScreenPageState extends ConsumerState<Theme01MainScreenPage> {
  int myCurrentIndex = 0;
  final pages = const [
    Theme01dhasboardPage(),
    Theme01Homepage(),
    Theme01Page(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myCurrentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.theme01secondaryColor4,
        selectedItemColor: AppColors.theme02buttonColor1,
        unselectedItemColor: AppColors.theme01primaryColor,
        iconSize: 25,
        onTap: (index) {
          setState(() {
            myCurrentIndex = index;
            // log('Index >>> $myCurrentIndex');
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
