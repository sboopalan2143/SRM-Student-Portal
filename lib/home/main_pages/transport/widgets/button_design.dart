import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/transport/riverpod/transport_state.dart';
import 'package:sample/home/main_pages/transport/screens/register.dart';
import 'package:sample/home/riverpod/main_provider.dart';

class ButtonDesign {
  static Widget buttonDesign(
    String text,
    Color color,
    BuildContext context,
    MainProvider provider,
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
        backgroundColor: AppColors.primaryColor,
        shadowColor: Colors.transparent,
      ),
      onPressed: () async {
        if (text == 'Register') {
          await Navigator.push(
                context,
                RouteDesign(
                  route: const TransportRegisterPage(),
                ),
              );
        }
        if (text == 'Submit') {
          await ref
              .read(transportProvider.notifier)
              .saveTransportstatusDetails(ref.read(
                encryptionProvider.notifier,
              ));
        }
      },
      child: Text(
        text,
        style: TextStyles.fontStyle13,
      ),
    );
  }
}
