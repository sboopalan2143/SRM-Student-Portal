import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppColors {
  static Color primaryColor = const Color(0xff236EDE);

  static Color secondaryColor = const Color(0xffF3F9FD);

  static const Color whiteColor = Color(0xffFFFFFF);

  static final primaryColorScheme = ThemeData().colorScheme.copyWith(
        primary: primaryColor,
      );

  static const Color loadingWrapperColor = Color(0xffC0DDF3);

  static const Color skyBlueColor = Color(0xff0087C9);

  static const Color blueColor = Color(0xffBDD7F1);

  static const Color blackColor = Color(0xff000000);

  static const Color transparentColor = Colors.transparent;

  static const Color redColor = Color(0xffF44336);

  static const Color yellowColor = Color(0xffFCB300);

  static const Color greenColor = Color(0xff42B72A);

  static const Color lightAshColor = Color(0xff89909B);

  static const Color grey = Color(0xff373A41);

  static const Color grey1 = Color(0xff35415F);

  static const Color grey2 = Color(0xffCCCDD2);

  static const Color grey3 = Color(0xffCCCDD2);

  static const Color grey4 = Color(0xffA7A7A7);

  static const Color skeletonColor = Color(0xffE0E0E0);

  static Future<void> setPrimaryColor(String color) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('primaryColor', color);
    final parseColor = Color(
      int.parse(
        sharedPreferences
            .getString('primaryColor')!
            .replaceAll('#', '0xFF')
            .toUpperCase(),
      ),
    );
    primaryColor = parseColor;
    log('primaryColor $primaryColor');
  }

  static Future<void> setSecondaryColor(String color) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('secondaryColor', color);
    final parseColor = Color(
      int.parse(
        sharedPreferences
            .getString('secondaryColor')!
            .replaceAll('#', '0xFF')
            .toUpperCase(),
      ),
    );
    secondaryColor = parseColor;
  }
}
