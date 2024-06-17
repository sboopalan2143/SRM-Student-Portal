import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:sample/designs/_designs.dart';

class AppNotification {
  static bool platformSupportsNotifications() =>
      Platform.isAndroid || Platform.isIOS;

  static Future<void> initializeNotification() async {
    if (platformSupportsNotifications()) {
      await AwesomeNotifications().initialize(
        'resource://drawable/ic_launcher',
        [
          NotificationChannel(
            channelKey: 'app_notification',
            channelName: 'App Notification',
            channelDescription:
                'Notification channel for application notifications',
            defaultColor: AppColors.primaryColor,
            importance: NotificationImportance.Max,
            criticalAlerts: true,
          ),
        ],
      );
    }
  }

  static Future<void> createNotification({
    required String title,
    required String body,
    String? networkImagePath,
  }) async {
    if (platformSupportsNotifications()) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'app_notification',
          title: title,
          body: body,
          bigPicture: networkImagePath,
          notificationLayout: networkImagePath != null
              ? NotificationLayout.BigPicture
              : NotificationLayout.Default,
        ),
      );
    }
  }
}
