import 'package:sample/designs/_designs.dart';
import 'package:flutter/material.dart';

class SnackBars {
  static void successSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        backgroundColor: AppColors.secondaryColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/images/successful_icon.png',
              height: 40,
              width: 40,
            ),
            const SizedBox(height: 15),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyles.smallPrimaryColorFontStyle,
            ),
          ],
        ),
      ),
    );
  }

  static void errorSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        backgroundColor: AppColors.secondaryColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/images/error_icon.png',
              height: 40,
              width: 40,
            ),
            const SizedBox(height: 15),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyles.smallPrimaryColorFontStyle,
            ),
          ],
        ),
      ),
    );
  }
}
