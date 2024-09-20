// ignore_for_file: avoid_dynamic_calls
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';
import 'package:sample/home/main_pages/grievances/screens/grievance_entry.dart';
import 'package:sample/home/riverpod/main_provider.dart';

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
            Radius.circular(9),
          ),
        ),
        elevation: 0,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: AppColors.primaryColor,
        shadowColor: Colors.transparent,
      ),
      onPressed: () async {
        if (text == 'Grievance Entry') {
          await Navigator.push(
            context,
            RouteDesign(
              route: const GrievanceEntryPage(),
            ),
          );
        }

        if (text == 'Submit') {
          final provider = ref.watch(grievanceProvider);
          if (provider.subject.text == '') {
            Alerts.errorAlert(
              message: 'subject cannot be empty',
              context: context,
            );
          } else if (provider.description.text == '') {
            Alerts.errorAlert(
              message: 'Description cannot be empty',
              context: context,
            );
          } else if (provider
                  .selectedgrievanceCaregoryDataList.grievancekcategoryid ==
              '') {
            Alerts.errorAlert(
              message: 'Grievance Category is empty',
              context: context,
            );
          } else if (provider
                  .selectedgrievanceSubTypeDataList.grievancesubcategoryid ==
              '') {
            Alerts.errorAlert(
              message: 'Grievance SubType is empty',
              context: context,
            );
          } else if (provider.selectedgrievanceTypeDataList.grievancetypeid ==
              '') {
            Alerts.errorAlert(
              message: 'Grievance Type is empty',
              context: context,
            );
          } else {
            await ref
                .read(grievanceProvider.notifier)
                .saveGrievanceDetails(ref.read(encryptionProvider.notifier));
          }
        }
      },
      child: Text(
        text,
        style: TextStyles.fontStyle13,
      ),
    );
  }
}
