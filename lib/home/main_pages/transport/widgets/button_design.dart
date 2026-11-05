import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:srmuh_std/designs/_designs.dart';
import 'package:srmuh_std/encryption/encryption_state.dart';
import 'package:srmuh_std/home/main_pages/transport/riverpod/transport_state.dart';
import 'package:srmuh_std/home/riverpod/main_provider.dart';
import 'package:srmuh_std/theme-07/mainscreens/transport/transport_register.dart';

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
        backgroundColor: AppColors.theme01secondaryColor4,
        shadowColor: Colors.transparent,
      ),
      onPressed: () async {
        if (text == 'Register') {
          await Navigator.push(
            context,
            RouteDesign(
              // route: const TransportRegisterPage(),
              route: const Theme07TransportRegisterPage(),
            ),
          );
          await ref.read(transportProvider.notifier).gettransportRegisterDetails(
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
        style: TextStyles.buttonStyle01theme2,
      ),
    );
  }
}
