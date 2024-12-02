import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/home/drawer_pages/profile/screens/profile_page.dart';
import 'package:sample/home/drawer_pages/theme/screens/theme.dart';
import 'package:sample/theme-01/drawer_page/theme01_profile_screen.dart';
import 'package:sample/theme-01/setting_page.dart';
import 'package:sample/theme-01/theme01_homepage.dart';

class Theme01MainScreenPage extends ConsumerStatefulWidget {
  const Theme01MainScreenPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme01MainScreenPageState();
}

class _Theme01MainScreenPageState extends ConsumerState<Theme01MainScreenPage> {
  int myCurrentIndex = 0;
  final pages = const [
    Theme01Homepage(),
    Theme01settingPage(),
    ProfilePage(),
    ThemePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myCurrentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.theme01primaryColor,
        selectedItemColor: AppColors.theme01secondaryColor1,
        unselectedItemColor: AppColors.whiteColor,
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
