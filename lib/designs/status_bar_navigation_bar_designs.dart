import 'package:sample/designs/_designs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarNavigationBarDesigns {
  static const statusBarNavigationBarDesign = SystemUiOverlayStyle(
    statusBarColor: AppColors.transparentColor,
    systemNavigationBarColor: AppColors.secondaryColor,
    systemNavigationBarDividerColor: AppColors.secondaryColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  static final noAppBar = AppBar(
    backgroundColor: AppColors.secondaryColor,
    toolbarHeight: 0,
    elevation: 0,
  );
}
