import 'package:flutter/material.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/route/route_names.dart';
import 'package:sample/theme-01/Theme_01_bottom_navigation_page.dart';
import 'package:sample/theme-02/login/theme02_login_screen.dart';
import 'package:sample/theme-02/theme_02_bottom_navigation_page.dart';
import 'package:sample/theme_3/bottom_navigation_page_theme3.dart';
import 'package:sample/theme_4/bottom_navigation_page_theme4.dart';
// import 'package:sample/theme-01/bottom_navigation_page.dart';
// import 'package:sample/theme-01/login/theme01_login_screen.dart';

class RouteBuilder {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    /// Login Page
    // Routes.login: (_) => const LoginPage2(),
    // if (TokensManagement.storedselectedTheme == 'Theme1')
    Routes.login: (_) => const Theme02LoginScreen(),

    // if (TokensManagement.storedselectedTheme == 'Theme2')
    //   Routes.login: (_) => const LoginScreen3(),

    // if (TokensManagement.storedselectedTheme == 'Theme3')
    //   Routes.login: (_) => const LoginPageTheme3(),

    // Routes.login: (_) => const LoginPageTheme4(),

    /// Home Page
    // Routes.home: (_) => const HomePage2(),

    if (TokensManagement.storedselectedTheme == 'Theme1')
      Routes.home: (_) => const Theme02MainScreenPage(),

    if (TokensManagement.storedselectedTheme == 'Theme2')
      Routes.home: (_) => const Theme01MainScreenPage(),

    if (TokensManagement.storedselectedTheme == 'Theme3')
      Routes.home: (_) => const MainScreenPage(),

    if (TokensManagement.storedselectedTheme == 'Theme4')
      Routes.home: (_) => const MainScreenPage4(),

    /// Profile Page
    // Routes.profile: (_) => const ProfilePage(),
  };
}
