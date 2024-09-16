// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/change_password/riverpod/change_password_state.dart';
import 'package:sample/home/riverpod/main_provider.dart';
import 'package:sample/login/riverpod/login_state.dart';
// import 'package:uuid/uuid.dart' show Uuid;

class ButtonDesign {
  static Widget buttonDesign(
    String text,
    Color color,
    BuildContext context,
    MainProvider provider,
    WidgetRef ref,
  ) {
    // const uuid = Uuid();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: AppColors.primaryColor,
        shadowColor: Colors.transparent,
      ),
      onPressed: () async {
        provider.setNavString('Home');
        if (text == 'Log In') {
          await ref
              .read(loginProvider.notifier)
              .login(ref.read(encryptionProvider.notifier));
        }
        if (text == 'Save') {
          await ref
              .read(changePasswordProvider.notifier)
              .changePassword(ref.read(encryptionProvider.notifier));
        }
      },
      child: Text(
        text,
        style: TextStyles.fontStyle1,
      ),
    );
  }
}
