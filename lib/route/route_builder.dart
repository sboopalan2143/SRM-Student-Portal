import 'package:flutter/material.dart';
import 'package:sample/home/screen/home_page2.dart';
import 'package:sample/login/screen/login_Page2.dart';
import 'package:sample/route/route_names.dart';
import 'package:sample/theme-01/login/theme01_login_screen.dart';
import 'package:sample/theme-01/theme01_homepage.dart';

class RouteBuilder {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    /// Login Page
    // Routes.login: (_) => const LoginPage2(),
    Routes.login: (_) => const LoginScreen3(),

    /// Home Page
    // Routes.home: (_) => const HomePage2(),
    Routes.home: (_) =>  Theme01Homepage(),
    

    /// Profile Page
    // Routes.profile: (_) => const ProfilePage(),
  };
}
