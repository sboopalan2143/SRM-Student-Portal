// ignore_for_file: avoid_dynamic_calls
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
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
        backgroundColor: AppColors.theme01secondaryColor4,
        shadowColor: Colors.transparent,
      ),
      onPressed: () async {
        if (text == 'Book Search') {
          provider.setNavString(
            'Book Search',
          );
        }
        if (text == 'Submit') {
          final provider = ref.watch(libraryProvider);
          if (provider.filter.text == '') {
            Alerts.errorAlert(
              message: 'Filter empty',
              context: context,
            );
          } else if (provider.filter.text.length < 3) {
            Alerts.errorAlert(
              message: 'Enter Morethan 3 Characters',
              context: context,
            );
          } else {
            await ref
                .read(libraryProvider.notifier)
                .saveLibrartBookSearchDetails(
                  ref.read(encryptionProvider.notifier),
                );
          }
        }
      },
      child: Text(
        text,
        style: TextStyles.buttonStyle01theme2,
      ),
    );
  }
}
