import 'package:flutter/material.dart';
import 'package:sample/home/screen/home_page2.dart';
import 'package:sample/login/screen/login_Page2.dart';
import 'package:sample/route/route_names.dart';

class RouteBuilder {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    /// Login Page
    Routes.login: (_) => const LoginPage2(),

    /// Home Page
    Routes.home: (_) => const HomePage2(),

    /// Profile Page
    // Routes.profile: (_) => const ProfilePage(),
  };
}
