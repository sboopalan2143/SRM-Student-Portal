import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/theme_3/attendance/attendance_page_theme3.dart';
import 'package:sample/theme_3/bottom_navigation_page_theme3.dart';
import 'package:sample/theme_3/menu_page_theme3.dart';

class AttendanceHomeTheme3 extends ConsumerStatefulWidget {
  const AttendanceHomeTheme3({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AttendanceHomeTheme3State();
}

class _AttendanceHomeTheme3State extends ConsumerState<AttendanceHomeTheme3> {
  MenuItem currentItem = MenuItems.home;

  @override
  Widget build(BuildContext context) => ZoomDrawer(
        openDragSensitivity: 250,
        borderRadius: 30,
        angle: -5,
        slideWidth: MediaQuery.of(context).size.width * 0.8,
        showShadow: true,
        menuBackgroundColor: AppColors.primaryColorTheme3,
        menuScreen: Builder(
          builder: (context) {
            return MenuPageTheme3(
              currentItem: currentItem,
              onSelectedItem: (MenuItem value) {
                setState(() {
                  currentItem = value;
                });
                ZoomDrawer.of(context)!.close();
              },
            );
          },
        ),
        mainScreen: getScreen(),
      );

  Widget getScreen() {
    switch (currentItem) {
      case MenuItems.home:
        return const AttendancePageTheme3();
      case MenuItems.main:
      default:
        return const MainScreenPage();
    }
  }
}
