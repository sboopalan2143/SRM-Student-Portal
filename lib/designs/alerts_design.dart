import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample/app_version_checker.dart';
import 'package:sample/designs/_designs.dart';
import 'package:url_launcher/url_launcher.dart';

class Alerts {
  static void checkForAppUpdate({
    required BuildContext context,
    required bool forcefully,
  }) {
    final versionChecker = AppVersionChecker();
    versionChecker.checkUpdate().then(
      (value) {
        if (value.newVersion != null &&
            value.newVersion != value.currentVersion) {
          final alert = AlertDialog(
            shape: BorderBoxButtonDecorations.primaryRectangleBorder,
            title: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/app_icon.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  'New version available. Please update and continue.',
                  style: TextStyles.alertContentStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    if (!forcefully)
                      Expanded(
                        child: TextButton(
                          child: Text(
                            'Skip',
                            style: TextStyles.smallerPrimaryColorFontStyle,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    Expanded(
                      child: TextButton(
                        child: Text(
                          forcefully ? 'Update App' : 'Update',
                          style: TextStyles.smallerPrimaryColorFontStyle,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          if (await canLaunchUrl(
                            Uri.parse('${value.appURL}'),
                          )) {
                            await launchUrl(
                              Uri.parse('${value.appURL}'),
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () async => !forcefully,
                child: alert,
              );
            },
          );
        }
      },
    );
  }

  static void appSettingAlert({
    required BuildContext context,
    required String message,
  }) {
    final alert = AlertDialog(
      shape: BorderBoxButtonDecorations.primaryRectangleBorder,
      backgroundColor: AppColors.whiteColor,
      actionsPadding: const EdgeInsets.only(right: 10, bottom: 10),
      title: const Text(
        'Error',
        style: TextStyles.smallBlackColorFontStyle,
      ),
      content: Text(
        message,
        style: TextStyles.smallPrimaryColorFontStyle,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyles.smallPrimaryColorFontStyle,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            openAppSettings();
          },
          child: Text(
            'Update',
            style: TextStyles.smallPrimaryColorFontStyle,
          ),
        ),
      ],
    );
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void successAlert({
    required BuildContext context,
    required String message,
  }) {
    final alert = AlertDialog(
      shape: BorderBoxButtonDecorations.primaryRectangleBorder,
      backgroundColor: AppColors.whiteColor,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            'assets/images/successful_icon.png',
            height: 40,
            width: 40,
          ),
          const SizedBox(height: 15),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyles.smallPrimaryColorFontStyle,
          ),
        ],
      ),
    );
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void errorAlert({
    required BuildContext context,
    required String message,
  }) {
    final alert = AlertDialog(
      shape: BorderBoxButtonDecorations.primaryRectangleBorder,
      backgroundColor: AppColors.whiteColor,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            'assets/images/error_icon.png',
            height: 40,
            width: 40,
          ),
          const SizedBox(height: 15),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyles.smallPrimaryColorFontStyle,
          ),
        ],
      ),
    );
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void loadingAlert({
    required BuildContext context,
    required String message,
  }) {
    final alert = AlertDialog(
      shape: BorderBoxButtonDecorations.primaryRectangleBorder,
      backgroundColor: AppColors.whiteColor,
      title: Row(
        children: <Widget>[
          CircularProgressIndicators.primaryColorProgressIndication,
          const SizedBox(width: 20),
          Text(
            message,
            style: TextStyles.smallPrimaryColorFontStyle,
          ),
        ],
      ),
    );
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: alert,
        );
      },
    );
  }
}
