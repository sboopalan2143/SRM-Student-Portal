// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/riverpod/main_provider.dart';
import 'package:sample/home/screen/home_page.dart';
// import 'package:uuid/uuid.dart' show Uuid;

class ButtonDesign {
  static Widget buttonDesign(
    String text,
    Color color,
    BuildContext context,
    MainProvider provider,
  ) {
    // const uuid = Uuid();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(9),
          ),
        ),
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: AppColors.primaryColor,
        shadowColor: Colors.transparent,
      ),
      onPressed: () {
        provider.setNavString('Home');
        Navigator.of(context).push(
          // ignore: inference_failure_on_instance_creation
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      },
      child: Text(
        text,
        style: TextStyles.fontStyle1,
      ),
    );
  }
}
