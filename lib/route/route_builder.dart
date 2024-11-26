import 'package:flutter/material.dart';
import 'package:sample/route/route_names.dart';
import 'package:sample/theme-01/bottom_navigation_page.dart';
import 'package:sample/theme-01/login/theme01_login_screen.dart';

class RouteBuilder {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    /// Login Page
    // Routes.login: (_) => const LoginPage2(),
    Routes.login: (_) => const LoginScreen3(),

    /// Home Page
    // Routes.home: (_) => const HomePage2(),
    Routes.home: (_) => const Theme01MainScreenPage(),

    /// Profile Page
    // Routes.profile: (_) => const ProfilePage(),
  };
}
