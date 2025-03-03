import 'package:flutter/material.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/home/screen/theme05_bottom_navigation_page.dart.dart';
import 'package:sample/route/route_names.dart';
import 'package:sample/theme-01/Theme_01_bottom_navigation_page.dart';
import 'package:sample/theme-02/login/theme02_login_screen.dart';
import 'package:sample/theme-02/theme_02_bottom_navigation_page.dart';
import 'package:sample/theme-06/theme_06_bottom_navigation_page.dart';
import 'package:sample/theme-07/login/login_page_theme07.dart';
import 'package:sample/theme-07/theme07_homepage.dart';
import 'package:sample/theme_3/bottom_navigation_page_theme3.dart';
import 'package:sample/theme_4/bottom_navigation_page_theme4.dart';

import '../login/screen/login_page.dart';

// import 'package:sample/theme-01/bottom_navigation_page.dart';
// import 'package:sample/theme-01/login/theme01_login_screen.dart';

class RouteBuilder {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    /// Login Page
    Routes.login: (_) => const Theme07LoginPage(),
    // if (TokensManagement.storedselectedTheme == 'Theme1')

    // Routes.login: (_) => const Theme02LoginScreen(),

    // if (TokensManagement.storedselectedTheme == 'Theme2')
    //   Routes.login: (_) => const LoginScreen3(),

    // if (TokensManagement.storedselectedTheme == 'Theme3')
    //   Routes.login: (_) => const LoginPageTheme3(),

    // Routes.login: (_) => const LoginPageTheme4(),

    if (TokensManagement.storedselectedTheme == 'Theme1')
      Routes.home: (_) => const Theme02MainScreenPage()
    else if (TokensManagement.storedselectedTheme == 'Theme2')
      Routes.home: (_) => const Theme01MainScreenPage()
    else if (TokensManagement.storedselectedTheme == 'Theme3')
      Routes.home: (_) => const MainScreenPage()
    else if (TokensManagement.storedselectedTheme == 'Theme4')
      Routes.home: (_) => const MainScreenPage4()
    else if (TokensManagement.storedselectedTheme == 'Theme5')
      Routes.home: (_) => const Theme05MainScreenPage()
    else if (TokensManagement.storedselectedTheme == 'Theme6')
      Routes.home: (_) => const Theme06MainScreenPage()
    else if (TokensManagement.storedselectedTheme == 'Theme7')
      Routes.home: (_) => const Theme07HomePage()
    else
      Routes.home: (_) => const Theme07HomePage(),

    /// Profile Page
    // Routes.profile: (_) => const ProfilePage(),
  };
}
