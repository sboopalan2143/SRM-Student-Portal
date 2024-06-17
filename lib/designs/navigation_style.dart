import 'package:flutter/material.dart';

class RouteDesign extends PageRouteBuilder<dynamic> {
  RouteDesign({required this.route})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return route;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ),
              ),
              child: child,
            );
          },
        );

  final Widget route;
}
