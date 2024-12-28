import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/home/drawer_pages/theme/screens/theme.dart';
import 'package:sample/home/main_pages/dhasboard_05_page.dart';
import 'package:sample/home/screen/home_page2.dart';

class Theme05MainScreenPage extends ConsumerStatefulWidget {
  const Theme05MainScreenPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme05MainScreenPageState();
}

class _Theme05MainScreenPageState extends ConsumerState<Theme05MainScreenPage> {
  int myCurrentIndex = 0;
  final pages = const [
    Theme05dhasboardPage(),
    HomePage2(),
    Theme05Page(),
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
