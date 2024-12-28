import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppColors {
  AppColors(Color primaryColor);

  static Color theme01primaryColor = const Color(0xff355B63);

  static Color theme02primaryColor = const Color(0xff514CA6);

  static Color theme01secondaryColor1 = const Color(0xffFFCC99);

  static Color theme01secondaryColor2 = const Color(0xffFFCC99);

  static Color theme01secondaryColor3 = const Color(0xffFEF1D8);

  static Color theme01secondaryColor4 = const Color(0xffFAE5C7);

  static Color theme02secondaryColor1 = const Color(0xff3A8ECC);

  static Color theme02buttonColor1 = const Color(0xffF44A1C);

  static Color theme02buttonColor2 = const Color(0xffF15D25);

  static Color theme06primaryColor = const Color(0xff6495ED);

  static Color primaryColorTheme3 = const Color(0xffAD1457);

  static Color secondaryColorTheme3 = const Color(0xffE0E0E0);

  static Color primaryColor = const Color(0xff236EDE);

  static Color secondaryColor = const Color(0xffF3F9FD);

  static const Color whiteColor = Color(0xffFFFFFF);

  static const Color primaryColor2 = Color(0xff2762F6);

  static final primaryColorScheme = ThemeData().colorScheme.copyWith(
        primary: primaryColor2,
      );

  static const Color greenColorTheme3 = Color(0xff78B33D);

  static const Color loadingWrapperColor = Color(0xffC0DDF3);

  static const Color homepagecolor1 = Color(0xffFFF3E7);

  static const Color homepagecolor2 = Color(0xffD7FFEC);

  static const Color homepagecolor3 = Color(0xffFFE5EE);

  static const Color homepagecolor4 = Color(0xffFFF3E7);

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

  static const Color whitecolor = Colors.white;

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
    log('primaryColor $primaryColor2');
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

  static const Color theme4color1 = Color(0xffed9255);

  static const Color theme4color2 = Color(0xfffb6c5b);

  static const Color theme4color3 = Color(0xff4678a9);

  static const Color secondaryColorTheme4 = Color.fromARGB(255, 240, 240, 241);

  static const LinearGradient primaryColorTheme4 = LinearGradient(
    colors: [
      Color(0xffed9255),
      Color(0xfffb6c5b),
    ], // Gradient colors
    begin: Alignment.topCenter, // Start point
    end: Alignment.bottomCenter, // End point
  );
}
