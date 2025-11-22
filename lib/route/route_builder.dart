import 'package:flutter/material.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/route/route_names.dart';
import 'package:sample/theme-07/bottom_navbar.dart';
import 'package:sample/theme-07/login/login_page_theme07.dart';
import 'package:sample/theme-07/theme07_homepage.dart';

// import 'package:sample/theme-01/bottom_navigation_page.dart';
// import 'package:sample/theme-01/login/theme01_login_screen.dart';

class RouteBuilder {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    /// Login Page
    Routes.login: (_) => const Theme07LoginPage(),

    Routes.home: (_) => const BottomBar(),

    /// Profile Page
    // Routes.profile: (_) => const ProfilePage(),
  };
}
