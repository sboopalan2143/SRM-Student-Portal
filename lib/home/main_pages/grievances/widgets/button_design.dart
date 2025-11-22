// ignore_for_file: avoid_dynamic_calls
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/change_password/riverpod/change_password_state.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        shadowColor: Colors.transparent,
      ),
      onPressed: () async {
        if (text == 'Grievance Entry') {
          // await Navigator.push(
          //   context,
          //   RouteDesign(
          //     route: const Theme06GrievanceEntryPage(),
          //   ),
          // );
        }

        if (text == 'Submit') {
          final provider = ref.watch(grievanceProvider);
          final watchprovider = ref.watch(changePasswordProvider);

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
          } else if (provider.selectedgrievanceCaregoryDataList.grievancekcategoryid == '') {
            Alerts.errorAlert(
              message: 'Grievance Category is empty',
              context: context,
            );
          } else if (provider.selectedgrievanceCaregoryDataList.grievancekcategoryid == '28' &&
              provider.selectedgrievanceSubTypeDataList.grievancesubcategoryid == '') {
            Alerts.errorAlert(
              message: 'Grievance SubType is empty',
              context: context,
            );
          } else if (provider.selectedgrievanceTypeDataList.grievancetypeid == '') {
            Alerts.errorAlert(
              message: 'Grievance Type is empty',
              context: context,
            );
          } else {
            await ref.read(grievanceProvider.notifier).saveGrievanceDetails(ref.read(encryptionProvider.notifier));
          }

          // if (watchprovider.confirmPassword.text == '') {
          //   Alerts.errorAlert(
          //     message: 'confirmPassword cannot be empty',
          //     context: context,
          //   );
          // } else if (watchprovider.currentPassword.text == '') {
          //   Alerts.errorAlert(
          //     message: 'currentPassword  cannot be empty',
          //     context: context,
          //   );
          // } else if (watchprovider.newPassword.text == '') {
          //   Alerts.errorAlert(
          //     message: 'newPassword  cannot be empty',
          //     context: context,
          //   );
          // }
        }
      },
      child: Text(
        text,
        style: TextStyles.fontStyletheme2,
      ),
    );
  }
}
