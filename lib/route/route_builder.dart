import 'package:sample/home/screen/home_page.dart';
import 'package:sample/login/screen/login_page.dart';
import 'package:sample/route/route_names.dart';
import 'package:flutter/material.dart';

class RouteBuilder {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    /// Login Page
    Routes.login: (_) => const LoginPage(),

    /// Home Page
    Routes.home: (_) => const HomePage(),

    /// Profile Page
    // Routes.profile: (_) => const ProfilePage(),
  };
}
