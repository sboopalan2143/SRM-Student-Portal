import 'package:flutter/material.dart';
import 'package:sample/designs/_designs.dart';

class CircularProgressIndicators {
  static final primaryColorProgressIndication = SizedBox(
    height: 30,
    width: 30,
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        AppColors.primaryColor,
      ),
    ),
  );

  static final theme01primaryColorProgressIndication = SizedBox(
    height: 30,
    width: 30,
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        AppColors.theme01secondaryColor4,
      ),
    ),
  );

  static final secondaryColorProgressIndication = SizedBox(
    height: 30,
    width: 30,
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        AppColors.secondaryColor,
      ),
    ),
  );
}
