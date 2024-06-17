import 'package:sample/designs/_designs.dart';
import 'package:flutter/material.dart';

class CircularProgressIndicators {
  static const primaryColorProgressIndication = SizedBox(
    height: 30,
    width: 30,
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        AppColors.primaryColor,
      ),
    ),
  );

  static const secondaryColorProgressIndication = SizedBox(
    height: 30,
    width: 30,
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        AppColors.secondaryColor,
      ),
    ),
  );
}
