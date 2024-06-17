// ignore_for_file: avoid_dynamic_calls
import 'package:flutter/material.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/riverpod/main_provider.dart';

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
        if (text == 'Grievance Entry') {
          provider.setNavString('Grievance Entry');
        }
      },
      child: Text(
        text,
        style: TextStyles.fontStyle13,
      ),
    );
  }
}
