import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/transport/riverpod/transport_state.dart';
import 'package:sample/home/riverpod/main_provider.dart';
import 'package:sample/theme-01/mainscreens/transport/transport_register.dart';
import 'package:sample/theme-02/mainscreens/transport/transport_register.dart';
import 'package:sample/theme-06/mainscreens/transport/transport_register.dart';

class TransportButtonDesign {
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
        backgroundColor: AppColors.theme02secondaryColor1,
        shadowColor: Colors.transparent,
      ),
      onPressed: () async {
        if (text == 'Register') {
          await Navigator.push(
            context,
            RouteDesign(
              // route: const TransportRegisterPage(),
              route: const Theme06TransportRegisterPage(),
            ),
          );
          await ref
              .read(transportProvider.notifier)
              .gettransportRegisterDetails(
                ref.read(encryptionProvider.notifier),
              );
          await ref.read(transportProvider.notifier).getRouteIdDetails(
                ref.read(encryptionProvider.notifier),
              );
        }
        if (text == 'Submit') {
          await ref.read(transportProvider.notifier).saveTransportstatusDetails(
                ref.read(
                  encryptionProvider.notifier,
                ),
              );
        }
      },
      child: Text(
        text,
        style: TextStyles.fontStyletheme2,
      ),
    );
  }
}
