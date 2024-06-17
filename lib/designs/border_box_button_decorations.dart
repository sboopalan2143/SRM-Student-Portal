import 'package:sample/designs/_designs.dart';
import 'package:flutter/material.dart';

class BorderBoxButtonDecorations {
  static final primaryBorderRadius = BorderRadius.circular(10);

  static final secondaryBorderRadius = BorderRadius.circular(5);

  static final primaryRectangleBorder = RoundedRectangleBorder(
    borderRadius: primaryBorderRadius,
  );

  static final secondaryRectangleBorder = RoundedRectangleBorder(
    borderRadius: secondaryBorderRadius,
  );

  static final primaryTextFieldBorder = OutlineInputBorder(
    borderRadius: primaryBorderRadius,
  );

  static OutlineInputBorder customTextFieldBorder({
    required Color borderColor,
  }) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor),
      borderRadius: primaryBorderRadius,
    );
  }

  static final textFieldShadow = BoxDecoration(
    color: AppColors.whiteColor,
    borderRadius: primaryBorderRadius,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        blurRadius: 10,
        offset: const Offset(0, 10),
      ),
    ],
  );

  static ButtonStyle primaryBorderButtonStyle({
    required Color backgroundColor,
  }) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        primaryRectangleBorder,
      ),
    );
  }

  static ButtonStyle secondaryBorderButtonStyle({
    required Color backgroundColor,
  }) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        secondaryRectangleBorder,
      ),
    );
  }

  static ButtonStyle primaryBorderColoredButtonStyle({
    required Color backgroundColor,
    required Color borderColor,
  }) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: primaryBorderRadius,
          side: BorderSide(color: borderColor, width: 2),
        ),
      ),
    );
  }

  static const backButton = Icon(
    Icons.arrow_back_ios_rounded,
    size: 23,
    color: AppColors.primaryColor,
  );

  static const noImageAvatarForProfile = Padding(
    padding: EdgeInsets.all(10),
    child: CircleAvatar(
      radius: 50,
      backgroundColor: AppColors.transparentColor,
      backgroundImage: AssetImage('assets/images/no_image.jpg'),
    ),
  );

  static const bottomModelSheetBorderRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
  );

  static final dragForBottomSheet = SizedBox(
    width: 50,
    height: 5,
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );

  static const primaryDivider = Divider(
    thickness: 2,
    color: AppColors.skeletonColor,
  );

  static const secondaryDivider = Divider(
    thickness: 2,
    color: AppColors.skeletonColor,
    indent: 20,
    endIndent: 20,
  );

  static final loginTextFieldStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: const BorderSide(color: AppColors.grey2),
  );

  static final loginErrorTextFieldStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: const BorderSide(color: AppColors.redColor),
  );

  static final homePageButtonStyle = ButtonStyle(
    shadowColor: MaterialStateProperty.all(AppColors.grey.withOpacity(0.5)),
    elevation: MaterialStateProperty.all(0),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(27)),
      ),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(AppColors.whiteColor),
    foregroundColor: MaterialStateProperty.all<Color>(AppColors.whiteColor),
    overlayColor: MaterialStateProperty.all<Color>(AppColors.whiteColor),
  );
}
