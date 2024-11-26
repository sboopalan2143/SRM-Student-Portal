import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/home/main_pages/hostel/screens/hostel_leave_application.dart';
import 'package:sample/home/main_pages/hostel/screens/registration.dart';
import 'package:sample/theme-01/mainscreens/hostel/hostel_leave_application.dart';
import 'package:sample/theme-01/mainscreens/hostel/hostel_register.dart';

class ButtonDesign {
  static Widget buttonDesign(
    String text,
    Color color,
    BuildContext context,
    WidgetRef ref,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(9),
          ),
        ),
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: AppColors.theme01secondaryColor1,
        shadowColor: Colors.transparent,
      ),
      onPressed: () {
        if (text == 'Leave Application') {
          Navigator.push(
            context,
            RouteDesign(
              // route: const LeaveApplicationPage(),
              route: const Theme01LeaveApplicationPage(),
            ),
          );
        }
        if (text == 'Registration') {
          Navigator.push(
            context,
            RouteDesign(
              // route: const RegistrationPage(),
              route: const Theme01RegistrationPage(),
            ),
          );
        }
        if (text == 'Register') {
          ref
              .read(hostelProvider.notifier)
              .hostelRegister(ref.read(encryptionProvider.notifier));
        }
        if (text == 'Submit') {
          ref
              .read(hostelProvider.notifier)
              .studentLeaveSubmit(ref.read(encryptionProvider.notifier));
        }
      },
      child: FittedBox(
        child: Text(
          text,
          style: TextStyles.buttonStyle01theme2,
        ),
      ),
    );
  }
}
